/** Called automatically by JsDoc Toolkit. */
function publish(symbolSet) {
    var outputDir = JSDOC.opt.d,
        outputFile = JSDOC.opt.D.outputFile,
        templatesDir = JSDOC.opt.t || SYS.pwd+"../templates/jsdoc-rails/";

	// is source output is suppressed, just display the links to the source file
	if (JSDOC.opt.s && defined(Link) && Link.prototype._makeSrcLink) {
		Link.prototype._makeSrcLink = function(srcFilePath) {
			return "&lt;"+srcFilePath+"&gt;";
		}
	}
	
	// used to allow Link to check the details of things being linked to
	Link.symbolSet = symbolSet;

	// create the required templates
	try {
		var classTemplate = new JSDOC.JsPlate(templatesDir + "seeds.tmpl");
	} catch(e) {
		print("Couldn't create the required templates: "+e);
		quit();
	}
	
	// some ustility filters
	function hasNoParent($) {return ($.memberOf == "")}
	function isaFile($) {return ($.is("FILE"))}
	function isaClass($) {return ($.is("CONSTRUCTOR") || $.isNamespace)}
	
	// get an array version of the symbolset, useful for filtering
	var symbols = symbolSet.toArray();
	
 	// get a list of all the classes in the symbolset
 	var classes = symbols.filter(isaClass).sort(makeSortby("alias"));

    classes.map(function($) {
        $.tag = $.alias.replace(/[\.#]+/g, '__');
        $.symbolType = '';
        if ($.isNamespace) {
            if ($.is('FUNCTION')) {
                $.symbolType = "function";
            }
            $.symbolType = "namespace";
        } else {
            $.symbolType = "class";
        }

        $.extendsList = $.augments.sort().join(", ");

		$.events = $.getEvents();   // 1 order matters
		$.methods = $.getMethods(); // 2
    });
	
	// create each of the class pages
    var output = "";
    output = classTemplate.process(classes);
    
    IO.saveFile(outputDir, outputFile, output);
}


/** Just the first sentence (up to a full stop). Should not break on dotted variable names. */
function summarize(desc) {
	if (typeof desc != "undefined")
		return desc.match(/([\w\W]+?\.)[^a-z0-9_$]/i)? RegExp.$1 : desc;
}

/** Make a symbol sorter by some attribute. */
function makeSortby(attribute) {
	return function(a, b) {
		if (a[attribute] != undefined && b[attribute] != undefined) {
			a = a[attribute].toLowerCase();
			b = b[attribute].toLowerCase();
			if (a < b) return -1;
			if (a > b) return 1;
			return 0;
		}
	}
}

/** Pull in the contents of an external file at the given path. */
function include(path) {
	var path = publish.conf.templatesDir+path;
	return IO.readFile(path);
}

/** Turn a raw source file into a code-hilited page in the docs. */
function makeSrcFile(path, srcDir, name) {
	if (JSDOC.opt.s) return;
	
	if (!name) {
		name = path.replace(/\.\.?[\\\/]/g, "").replace(/[\\\/]/g, "_");
		name = name.replace(/\:/g, "_");
	}
	
	var src = {path: path, name:name, charset: IO.encoding, hilited: ""};
	
	if (defined(JSDOC.PluginManager)) {
		JSDOC.PluginManager.run("onPublishSrc", src);
	}

	if (src.hilited) {
		IO.saveFile(srcDir, name+publish.conf.ext, src.hilited);
	}
}

/** Build output for displaying function parameters. */
function makeSignature(params) {
	if (!params) return "()";
	var signature = "("
	+
	params.filter(
		function($) {
			return $.name.indexOf(".") == -1; // don't show config params in signature
		}
	).map(
		function($) {
			return $.name;
		}
	).join(", ")
	+
	")";
	return signature;
}

/** Find symbol {@link ...} strings in text and turn into html links */
function resolveLinks(str, from) {
	str = str.replace(/\{@link ([^} ]+) ?\}/gi,
		function(match, symbolName) {
			return new Link().toSymbol(symbolName);
		}
	);
	
	return str;
}

function indentString(str, indent) {
    var indentStr = '';
    for (var i=0; i<indent; i++) {
        indentStr += ' ';
    }

    return indentStr + str.replace(/\n/g, "\n" + indentStr);
}

function toYAML(obj, indent) {
    indent = indent || 0;

    var output = '';
    for (var key in obj) {
        var val = obj[key];

        output += key + ": "

        switch (typeof(val)) {
        case 'object':
            output += "\n"
            output += toYAML(val, indent +2);
            break;
        case 'string':
            if (val != '') {
                output += '"' + val.replace(/"/g, '\\"') + '"';
            }
            break;

        case 'undefined':
            break;
        default:
            output += val.toString();
            break;
        }
        output += "\n";
    }


    output = indentString(output, indent);

    return output;
}
function toRuby(val) {
    var output = '';

    switch (typeof(val)) {
    case 'object':
        output += "\n"
        output += toYAML(val, indent +2);
        break;
    case 'string':
        if (val != '') {
            output += '"' + val.replace(/"/g, '\\"') + '"';
        } else {
            output += 'nil';
        }
        break;

    case 'undefined':
        output += 'nil';
        break;
    default:
        output += val.toString();
        break;
    }

    return output;
}
