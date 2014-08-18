<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html
	PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en   ">

  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name='author' content="Bruce Williams (http://codefluency.com), for
Ruby Central (http://rubycentral.org)">
	<title>RubyForge: Exiting with error</title>
<link rel="alternate" type="text/xml" title="RSS" href="http://rubyforge.org/export/rss_sfnews.php">
        <link rel="Shortcut Icon" href="http://static.rubyforge.vm.bytemark.co.uk/themes/rubyforge/images/favicon.ico"/>
	<script language="JavaScript" type="text/javascript">
	<!--
	function help_window(helpurl) {
		HelpWin = window.open( 'http://rubyforge.org' + helpurl,'HelpWindow','scrollbars=yes,resizable=yes,toolbar=no,height=400,width=400');
	}
	// -->
	</script>

<style type="text/css">
	<!--

        body {
          margin: 0px;
          background: #fff;
        }

	OL,UL,P,BODY,TR,TD,TH,FORM {
		font-family: Lucida Grande,verdana,arial,helvetica,sans-serif;
		font-size:13px;
		color: #202020;
	}

	HR { margin: 2px 0px 2px 0px }


	H1 { font-size: x-large; font-family: Lucida Grande,verdana,arial,helvetica,sans-serif; }
	H2 { font-size: large; font-family: Lucida Grande,verdana,arial,helvetica,sans-serif; }
	H3 { font-size: medium; font-family: Lucida Grande,verdana,arial,helvetica,sans-serif; }
	H4 { font-size: small; font-family: Lucida Grande,verdana,arial,helvetica,sans-serif; }
	H5 { font-size: x-small; font-family: Lucida Grande,verdana,arial,helvetica,sans-serif; }
	H6 { font-size: xx-small; font-family: Lucida Grande,verdana,arial,helvetica,sans-serif; }

	PRE,TT { font-family: courier,sans-serif }
  a {
    color: #cc3333;
    text-decoration: none;
  }
  a img {
    border: 0px;
  }
  table em {
    font-style: normal;
    font-weight: bold;
    color: #666;
    margin-left: 0px;
  }
  hr { /* unfortunately hrs are hardcoded */
    height: 2px;
    color: #e6e6e6;
    background: #e6e6e6;
    border: 0px;
  }
  td hr {
    margin-top: 0.5em;
    margin-bottom: 0.5em;
  }
        #header {
          height: 79px;
          background: #fff url(http://static.rubyforge.vm.bytemark.co.uk/themes/rubyforge/images/header-bg.png) bottom left repeat-x;
          margin: 0px;
        }
        #header-right {
          position: absolute;
          top: 0px;
          right: 0px;
          width: 40%;
        }
        #search {
          margin: 10px;
        }
        #controls {
          padding: 0px;
          height: 20px;
          line-height: 20px;
          vertical-align: middle;
          background: url(http://static.rubyforge.vm.bytemark.co.uk/themes/rubyforge/images/controls-bg.png) top left repeat-x;
        }
        #controls img {
          float: left;
          margin-right: 1em;
        }
        #controls a {
          padding: 0px;
          margin: 0px;
          color: #fff;
          text-decoration: none;
          margin-right: 1em;
        }
        #controls a:hover {
          color: #ffffcc;
        }
        #content {
          padding-left: 2em;
          padding-right: 2em;
        }
        .tabs {
          clear: both;
          margin: 0px;
          height: 26px;
          padding: 0px;
        }
        #outer-tabs {
          background: #fff url(http://static.rubyforge.vm.bytemark.co.uk/themes/rubyforge/images/tabs-bg.png) top left repeat-x;
        }
        #inner-tabs {
          background: #fff url(http://static.rubyforge.vm.bytemark.co.uk/themes/rubyforge/images/inner-tabs-bg.png) top left repeat-x;
        }
        .tabs li {
          padding: 4px;
          padding-left: 10px;
          padding-right: 10px;
          float: left;
          display: block;
          margin-left: 0.5em;
        }
        .tabs li a {
          color: #444;
          text-decoration: none;
          font-size: 14px;
          font-weight: bold;
        }
        .tabs li a:hover {
          color: red; }
        #outer-tabs li.active {
          background: url(http://static.rubyforge.vm.bytemark.co.uk/themes/rubyforge/images/active-tab-bg.png) top left repeat-x;
        }
        #inner-tabs li a {
          font-size: 13px; }
        #inner-tabs li.active {
          background: url(http://static.rubyforge.vm.bytemark.co.uk/themes/rubyforge/images/active-inner-tab-bg.png) top left repeat-x;
        }
        .tabs li.active a {
          color: #000;
        }
        #fade { 
          background: url(http://static.rubyforge.vm.bytemark.co.uk/themes/rubyforge/images/bottom-fade-bg.png) bottom left repeat-x;
          height: 13px;
        }

        .titlebar {
          background: #FFFFCC;
          padding: 4px;
          font-size: 14px;
          font-weight: bold;
          border-bottom: 1px #fab444 solid; }
        .files-header td {
          background: #ffffcc;
          border: 1px #fab444 solid;
        }
        .files-header td * {
          background: none;
          border: 0px; }
        .files-header + tr td {
          background: #ddd;
        }
        .files-header + tr td * {
          background: none;
          border: 0px;
          color: #666;
        }
        .package td {
          background: #ffffcc;
        }
	-->
  </style>
</head>
<body>

<div id='header'><div id='header-right'>
    <div id='controls'><img alt='' src='http://static.rubyforge.vm.bytemark.co.uk/themes/rubyforge/images/controls-left.png'/>
      				<a href="/account/login.php">Log In</a>
				<a href="/projects/support/">Support</a>
				<a href="/account/register.php">New Account</a>
          </div>
    <div id='search'>
		<form action="/search/" method="get">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr><td>
		<div align="center" style="font-size:smaller"><select name="type_of_search"><option value="soft">Software/Group</option>
<option value="people">People</option>
<option value="skill">Skill</option>
</select></div></td><td>&nbsp;<input type="hidden" value="0" name="group_id" /></td><td><input type="text" size="12" name="words" value="" /></td><td>&nbsp;</td><td><input type="submit" name="Search" value="Search" /></td>
					<td width="10">&nbsp;</td>
					<td><b><a style="color: #FFFFFF" href="/search/advanced_search.php?group_id="> Advanced search</a></b></td></tr></table></form></div>
  </div>
  <a href='/' title='Back to Homepage'><img alt='RubyForge' src='http://static.rubyforge.vm.bytemark.co.uk/themes/rubyforge/images/header.png'/></a>
  <a href='http://rubydcamp.org/'><img alt='Ruby DC Camp' src='/images/rubydcamp_logo.png'/></a> 
  <a href='http://scrubyconf.colaruby.org/'><img alt='South Carolina Ruby Conference' src='/images/rubyforge_scruby.png'/></a> 
</div>
<ul id="outer-tabs"
class="tabs"><li><a href='/'>Home</a></li><li class='active'><a href='/my/'>My&nbsp;Page</a></li><li><a href='/softwaremap/'>Project&nbsp;Tree</a></li><li><a href='/snippet/'>Code&nbsp;Snippets</a></li><li><a href='/people/'>Project&nbsp;Openings</a></li></ul><div id='fade'></div>

<div id='content'>
<table border="0" width="100%" cellspacing="0" cellpadding="0">

			<tr>
				<td><img
					src="http://static.rubyforge.vm.bytemark.co.uk/themes/rubyforge/images/clear.png" width="10" height="1" alt="" /></td>
				<td valign="top" width="99%">
	<h2><span style="color:#FF3333">Invalid Project</span></h2><p>Invalid Project</p>
			&nbsp;<p>
			<!-- end main body row -->


				</td>
				<td width="10"><img
					src="http://static.rubyforge.vm.bytemark.co.uk/themes/rubyforge/images/clear.png" width="2" height="1" alt="" /></td>
			</tr>
			<tr>
				<td><img
					src="http://static.rubyforge.vm.bytemark.co.uk/themes/rubyforge/images/clear.png" width="1" height="1" alt="" /></td>
			</tr>
			</table>

		<!-- end inner body row -->

		</td>
		<td width="10"><img src="http://static.rubyforge.vm.bytemark.co.uk/themes/rubyforge/images/clear.png" width="2" height="1" alt="" /></td>
	</tr>
	<tr>
		<!-- some extra space to make it look nicer -->
		<td height="100">&nbsp;</td>
    
	</tr>
</table>

    </div>
  </body>
</html>
