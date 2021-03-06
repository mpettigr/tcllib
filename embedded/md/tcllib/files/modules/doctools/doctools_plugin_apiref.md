
[//000000001]: # (doctools\_plugin\_apiref \- Documentation tools)
[//000000002]: # (Generated from file 'doctools\_plugin\_apiref\.man' by tcllib/doctools with format 'markdown')
[//000000003]: # (Copyright &copy; 2007\-2010 Andreas Kupries <andreas\_kupries@users\.sourceforge\.net>)
[//000000004]: # (doctools\_plugin\_apiref\(n\) 1\.1 tcllib "Documentation tools")

<hr> [ <a href="../../../../toc.md">Main Table Of Contents</a> &#124; <a
href="../../../toc.md">Table Of Contents</a> &#124; <a
href="../../../../index.md">Keyword Index</a> &#124; <a
href="../../../../toc0.md">Categories</a> &#124; <a
href="../../../../toc1.md">Modules</a> &#124; <a
href="../../../../toc2.md">Applications</a> ] <hr>

# NAME

doctools\_plugin\_apiref \- doctools plugin API reference

# <a name='toc'></a>Table Of Contents

  - [Table Of Contents](#toc)

  - [Synopsis](#synopsis)

  - [Description](#section1)

  - [OVERVIEW](#section2)

  - [FRONTEND COMMANDS](#section3)

  - [PLUGIN COMMANDS](#section4)

      - [Management commands](#subsection1)

      - [Formatting commands](#subsection2)

  - [Bugs, Ideas, Feedback](#section5)

  - [See Also](#seealso)

  - [Keywords](#keywords)

  - [Category](#category)

  - [Copyright](#copyright)

# <a name='synopsis'></a>SYNOPSIS

[__dt\_copyright__](#1)  
[__dt\_file__](#2)  
[__dt\_mainfile__](#3)  
[__dt\_fileid__](#4)  
[__dt\_fmap__ *symfname*](#5)  
[__dt\_format__](#6)  
[__dt\_imgdata__ *key* *extensions*](#7)  
[__dt\_imgdst__ *key* *extensions*](#8)  
[__dt\_imgsrc__ *key* *extensions*](#9)  
[__dt\_lnesting__](#10)  
[__dt\_module__](#11)  
[__dt\_read__ *file*](#12)  
[__dt\_source__ *file*](#13)  
[__dt\_user__](#14)  
[__ex\_cappend__ *text*](#15)  
[__ex\_cget__ *varname*](#16)  
[__ex\_cis__ *cname*](#17)  
[__ex\_cname__](#18)  
[__ex\_cpop__ *cname*](#19)  
[__ex\_cpush__ *cname*](#20)  
[__ex\_cset__ *varname* *value*](#21)  
[__ex\_lb__ ?*newbracket*?](#22)  
[__ex\_rb__ ?*newbracket*?](#23)  
[__fmt\_initialize__](#24)  
[__fmt\_listvariables__](#25)  
[__fmt\_numpasses__](#26)  
[__fmt\_postprocess__ *text*](#27)  
[__fmt\_setup__ *n*](#28)  
[__fmt\_shutdown__](#29)  
[__fmt\_varset__ *varname* *text*](#30)  
[__fmt\_plain\_text__ *text*](#31)  

# <a name='description'></a>DESCRIPTION

This document is intended for *plugin writers*, i\.e\. developers wishing to
write a doctools *[formatting
engine](\.\./\.\./\.\./\.\./index\.md\#formatting\_engine)* for some output format X\.

It specifies the interaction between the __[doctools](doctools\.md)__
package and its plugins, i\.e\. the interface any doctools formatting engine has
to comply with\.

This document deals with version 1 of the interface\.

A reader who is on the other hand more interested in the markup language itself
should start with the *[doctools language
introduction](doctools\_lang\_intro\.md)* and proceed from there to the formal
specifications, i\.e\. the *[doctools language
syntax](doctools\_lang\_syntax\.md)* and the *[doctools language command
reference](doctools\_lang\_cmdref\.md)*\.

# <a name='section2'></a>OVERVIEW

The API for a doctools formatting engine consists of two major sections\.

On the one side we have a set of commands through which the plugin is able to
query the frontend\. These commands are provided by the frontend and linked into
the plugin interpreter\. Please see section [FRONTEND COMMANDS](#section3)
for their detailed specification\.

And on the other side the plugin has to provide its own set of commands which
will then be called by the frontend in a specific sequence while processing
input\. They, again, fall into two categories, management and formatting\. Please
see section [PLUGIN COMMANDS](#section4) and its subsections for their
detailed specification\.

# <a name='section3'></a>FRONTEND COMMANDS

This section specifies the set of commands through which a plugin, also known as
a doctools formatting engine, is able to query the frontend\. These commands are
provided by the frontend and linked into the plugin interpreter\.

I\.e\. a doctools formatting engine can assume that all of the following commands
are present when any of its own commands \(as specified in section [PLUGIN
COMMANDS](#section4)\) are executed\.

Beyond that it can also assume that it has full access to its own safe
interpreter and thus is not able to damage the other parts of the processor, nor
can it damage the filesystem\. It is however able to either kill or hang the
whole process, by exiting, or running an infinite loop\.

Coming back to the imported commands, all the commands with prefix *dt\_*
provide limited access to specific parts of the frontend, whereas the commands
with prefix *ex\_* provide access to the state of the
__[textutil::expander](\.\./textutil/expander\.md)__ object which does the
main parsing of the input within the frontend\. These commands should not be
except under very special circumstances\.

  - <a name='1'></a>__dt\_copyright__

    Query command\. It returns a string containing the copyright information the
    doctools processor was configured with\. The relevant option is
    __\-copyright__\)\.

  - <a name='2'></a>__dt\_file__

    Query command\. It returns the full path of the file containing the input
    currently processed by the engine\. This may be an included file\.

  - <a name='3'></a>__dt\_mainfile__

    Query command\. It returns the full path of the toplevel file containing the
    input currently processed by the engine\.

  - <a name='4'></a>__dt\_fileid__

    Query command\. It returns the name of the file containing the input
    currently processed by the engine, without path, nor extension\.

  - <a name='5'></a>__dt\_fmap__ *symfname*

    Query command\. It returns the actual pathname to use in the output in place
    of the symbolic filename *symfname*\. It will return the unchanged input if
    no mapping was established for *symfname*\.

    The required mappings are established with the method __map__ of a
    frontend, as explained in section __OBJECT METHODS__ of the
    documentation for the package __[doctools](doctools\.md)__\.

  - <a name='6'></a>__dt\_format__

    Query command\. It returns the name of the format associated with the
    doctools formatting engine\.

  - <a name='7'></a>__dt\_imgdata__ *key* *extensions*

    Query command\. Access to the image map\. Looks for an image recorded under
    the *key* and having on the specified *extension*\. If a matching image
    is found its data is returned as the result of the command\. Otherwise an
    empty string is returned\.

  - <a name='8'></a>__dt\_imgdst__ *key* *extensions*

    Query command\. Access to the image map\. Looks for an image recorded under
    the *key* and having on the specified *extension*\. If a matching image
    is found its destination path in the output is returned as the result of the
    command\. Otherwise an empty string is returned\.

  - <a name='9'></a>__dt\_imgsrc__ *key* *extensions*

    Query command\. Access to the image map\. Looks for an image recorded under
    the *key* and having on the specified *extension*\. If a matching image
    is found its origin path is returned as the result of the command\. Otherwise
    an empty string is returned\.

  - <a name='10'></a>__dt\_lnesting__

    Query command\. It returns the number of lists currently open\.

  - <a name='11'></a>__dt\_module__

    Query command\. It returns the name of the module the input currently
    processed belongs to\.

  - <a name='12'></a>__dt\_read__ *file*

    Controlled filesystem access\. Returns contents of *file* for whatever use
    desired by the plugin\. Only files which are either in the same directory as
    the file containing the engine, or below it, can be loaded\. Trying to load a
    file outside of this directory causes an error\.

  - <a name='13'></a>__dt\_source__ *file*

    Controlled filesystem access\. This command allows the doctools formatting
    engine to load additional Tcl code it may need\. Only files which are either
    in the same directory as the file containing the engine, or below it, can be
    loaded\. Trying to load a file outside of this directory causes an error\.

  - <a name='14'></a>__dt\_user__

    Query command\. It returns the name of the current user as known to the tcl
    interpreter the frontend controlling the formatting engine resides in\.

  - <a name='15'></a>__ex\_cappend__ *text*

    Appends a string to the output in the current context\. This command should
    rarely be used by macros or application code\.

  - <a name='16'></a>__ex\_cget__ *varname*

    Retrieves the value of variable *varname*, defined in the current context\.

  - <a name='17'></a>__ex\_cis__ *cname*

    Determines whether or not the name of the current context is *cname*\.

  - <a name='18'></a>__ex\_cname__

    Returns the name of the current context\.

  - <a name='19'></a>__ex\_cpop__ *cname*

    Pops a context from the context stack, returning all accumulated output in
    that context\. The context must be named *cname*, or an error results\.

  - <a name='20'></a>__ex\_cpush__ *cname*

    Pushes a context named *cname* onto the context stack\. The context must be
    popped by __cpop__ before expansion ends or an error results\.

  - <a name='21'></a>__ex\_cset__ *varname* *value*

    Sets variable *varname* to *value* in the current context\.

  - <a name='22'></a>__ex\_lb__ ?*newbracket*?

    Returns the current value of the left macro expansion bracket; this is for
    use as or within a macro, when the bracket needs to be included in the
    output text\. If *newbracket* is specified, it becomes the new bracket, and
    is returned\.

  - <a name='23'></a>__ex\_rb__ ?*newbracket*?

    Returns the current value of the right macro expansion bracket; this is for
    use as or within a macro, when the bracket needs to be included in the
    output text\. If *newbracket* is specified, it becomes the new bracket, and
    is returned\.

# <a name='section4'></a>PLUGIN COMMANDS

The plugin has to provide its own set of commands which will then be called by
the frontend in a specific sequence while processing input\. They fall into two
categories, management and formatting\. Their expected names, signatures, and
responsibilities are specified in the following two subsections\.

## <a name='subsection1'></a>Management commands

The management commands a plugin has to provide are used by the frontend to

  1. initialize and shutdown the plugin

  1. determine the number of passes it has to make over the input

  1. initialize and shutdown each pass

  1. query and initialize engine parameters

After the plugin has been loaded and the frontend commands are established the
commands will be called in the following sequence:

    fmt_numpasses -> n
    fmt_listvariables -> vars

    fmt_varset var1 value1
    fmt_varset var2 value2
    ...
    fmt_varset varK valueK
    fmt_initialize
    fmt_setup 1
    ...
    fmt_setup 2
    ...
    ...
    fmt_setup n
    ...
    fmt_postprocess
    fmt_shutdown
    ...

I\.e\. first the number of passes and the set of available engine parameters is
established, followed by calls setting the parameters\. That second part is
optional\.

After that the plugin is initialized, the specified number of passes executed,
the final result run through a global post processing step and at last the
plugin is shutdown again\. This can be followed by more conversions, restarting
the sequence at __fmt\_varset__\.

In each of the passes, i\.e\. after the calls of __fmt\_setup__ the frontend
will process the input and call the formatting commands as markup is
encountered\. This means that the sequence of formatting commands is determined
by the grammar of the doctools markup language, as specified in the *[doctools
language syntax](doctools\_lang\_syntax\.md)* specification\.

A different way of looking at the sequence is:

  - First some basic parameters are determined\.

  - Then everything starting at the first __fmt\_varset__ to
    __fmt\_shutdown__ forms a *run*, the formatting of a single input\. Each
    run can be followed by more\.

  - Embedded within each run we have one or more *passes*, each starting with
    __fmt\_setup__ and going until either the next __fmt\_setup__ or
    __fmt\_postprocess__ is reached\.

    If more than one pass is required to perform the formatting only the output
    of the last pass is relevant\. The output of all the previous, preparatory
    passes is ignored\.

The commands, their names, signatures, and responsibilities are, in detail:

  - <a name='24'></a>__fmt\_initialize__

    *Initialization/Shutdown*\. This command is called at the beginning of
    every conversion run, as the first command of that run\. Note that a run is
    not a pass, but may consist of multiple passes\. It has to initialize the
    general state of the plugin, beyond the initialization done during the load\.
    No return value is expected, and any returned value is ignored\.

  - <a name='25'></a>__fmt\_listvariables__

    *Initialization/Shutdown* and *Engine parameters*\. Second command is
    called after the plugin code has been loaded, i\.e\. immediately after
    __fmt\_numpasses__\. It has to return a list containing the names of the
    parameters the frontend can set to configure the engine\. This list can be
    empty\.

  - <a name='26'></a>__fmt\_numpasses__

    *Initialization/Shutdown* and *Pass management*\. First command called
    after the plugin code has been loaded\. No other command of the engine will
    be called before it\. It has to return the number of passes this engine
    requires to fully process the input document\. This value has to be an
    integer number greater or equal to one\.

  - <a name='27'></a>__fmt\_postprocess__ *text*

    *Initialization/Shutdown*\. This command is called immediately after the
    last pass in a run\. Its argument is the result of the conversion generated
    by that pass\. It is provided to allow the engine to perform any global
    modifications of the generated document\. If no post\-processing is required
    for a specific format the command has to just return the argument\.

    Expected to return a value, the final result of formatting the input\.

  - <a name='28'></a>__fmt\_setup__ *n*

    *Initialization/Shutdown* and *Pass management*\. This command is called
    at the beginning of each pass over the input in a run\. Its argument is the
    number of the pass which has begun\. Passes are counted from __1__
    upward\. The command has to set up the internal state of the plugin for this
    particular pass\. No return value is expected, and any returned value is
    ignored\.

  - <a name='29'></a>__fmt\_shutdown__

    *Initialization/Shutdown*\. This command is called at the end of every
    conversion run\. It is the last command called in a run\. It has to clean up
    of all the run\-specific state in the plugin\. After the call the engine has
    to be in a state which allows the initiation of another run without fear
    that information from the last run is leaked into this new run\. No return
    value is expected, and any returned value is ignored\.

  - <a name='30'></a>__fmt\_varset__ *varname* *text*

    *Engine parameters*\. This command is called by the frontend to set an
    engine parameter to a particular value\. The parameter to change is specified
    by *varname*, the value to set in *text*\.

    The command has to throw an error if an unknown *varname* is used\. Only
    the names returned by __fmt\_listvariables__ have to be considered as
    known\.

    The values of all engine parameters have to persist between passes and runs\.

## <a name='subsection2'></a>Formatting commands

The formatting commands have to implement the formatting for the output format,
for all the markup commands of the doctools markup language, except __lb__,
__rb__, __vset__, __include__, and
__[comment](\.\./\.\./\.\./\.\./index\.md\#comment)__\. These exceptions are
processed by the frontend and are never seen by the plugin\. In return a command
for the formatting of plain text has to be provided, something which has no
markup in the input at all\.

This means, that each of the 49 markup commands specified in the *[doctools
language command reference](doctools\_lang\_cmdref\.md)* and outside of the set
of exceptions listed above has an equivalent formatting command which takes the
same arguments as the markup command and whose name is the name of markup
command with the prefix *fmt\_* added to it\.

All commands are expected to format their input in some way per the semantics
specified in the command reference and to return whatever part of this that they
deem necessary as their result, which will be added to the output\.

To avoid essentially duplicating the command reference we do not list any of the
command here and simply refer the reader to the *[doctools language command
reference](doctools\_lang\_cmdref\.md)* for their signature and description\.
The sole exception is the plain text formatter, which has no equivalent markup
command\.

The calling sequence of formatting commands is not as rigid as for the
management commands, but determined by the grammar of the doctools markup
language, as specified in the *[doctools language
syntax](doctools\_lang\_syntax\.md)* specification\.

  - <a name='31'></a>__fmt\_plain\_text__ *text*

    *No associated markup command*\.

    Called by the frontend for any plain text encountered in the input\. It has
    to perform any and all special processing required for plain text\.

    The formatted text is expected as the result of the command, and added to
    the output\. If no special processing is required it has to simply return its
    argument without change\.

# <a name='section5'></a>Bugs, Ideas, Feedback

This document, and the package it describes, will undoubtedly contain bugs and
other problems\. Please report such in the category *doctools* of the [Tcllib
Trackers](http://core\.tcl\.tk/tcllib/reportlist)\. Please also report any ideas
for enhancements you may have for either package and/or documentation\.

When proposing code changes, please provide *unified diffs*, i\.e the output of
__diff \-u__\.

Note further that *attachments* are strongly preferred over inlined patches\.
Attachments can be made by going to the __Edit__ form of the ticket
immediately after its creation, and then using the left\-most button in the
secondary navigation bar\.

# <a name='seealso'></a>SEE ALSO

[doctools](doctools\.md), [doctools\_intro](doctools\_intro\.md),
[doctools\_lang\_cmdref](doctools\_lang\_cmdref\.md),
[doctools\_lang\_faq](doctools\_lang\_faq\.md),
[doctools\_lang\_intro](doctools\_lang\_intro\.md),
[doctools\_lang\_syntax](doctools\_lang\_syntax\.md)

# <a name='keywords'></a>KEYWORDS

[document](\.\./\.\./\.\./\.\./index\.md\#document),
[formatter](\.\./\.\./\.\./\.\./index\.md\#formatter), [formatting
engine](\.\./\.\./\.\./\.\./index\.md\#formatting\_engine),
[manpage](\.\./\.\./\.\./\.\./index\.md\#manpage),
[markup](\.\./\.\./\.\./\.\./index\.md\#markup), [semantic
markup](\.\./\.\./\.\./\.\./index\.md\#semantic\_markup)

# <a name='category'></a>CATEGORY

Documentation tools

# <a name='copyright'></a>COPYRIGHT

Copyright &copy; 2007\-2010 Andreas Kupries <andreas\_kupries@users\.sourceforge\.net>
