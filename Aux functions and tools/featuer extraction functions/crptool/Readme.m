<?PHP
    $fp=fopen('Private/install.m','r');
    $i=0;
    while($i<1000 && $zeile = fgets($fp,300))
    {
      $i++;
      if(preg_match("[^%<-- Header begins here -->]",$zeile))
      {
        $temp=fgets($fp,300);
        $time=strtr(chop(fgets($fp,300)),array ('%@' => ''));
        $ver=strtr(chop(fgets($fp,300)),array ('%@' => ''));
      }
    }
    fclose($fp);
?>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<head>
   <link rel="STYLESHEET" HREF="physik.css" CHARSET="ISO-8859-1" TYPE="text/css">
   <link rel="SHORTCUT ICON" href="favicon.ico">
   <link rel="first" href="../intro.html" title="intro">
   <link rel="start" href="content_notes.php" title="top">
   <link rel="prev" href="toolbox_control.html" title="contents">
   <link rel="next" href="content_gpl.html" title="GNU general public license">
   <link rel="last" href="content_winplot.html" title="winplot">
   <link rel="contents" href="toolbox_control.html" title="contents">
   <link rel="section" href="content_notes.php" title="release notes">
   <link rel="section" href="content_gpl.html" title="GNU general public license">
   <link rel="section" href="content_theory.html" title="theoretical background">
   <link rel="section" href="content_install.php" title="installation">
   <link rel="section" href="content_error.html" title="error handling">
   <link rel="section" href="content_doc.html" title="printable reference manual">
   <link rel="section" href="content_ace.html" title="ace">
   <link rel="section" href="content_adjust.html" title="adjust">
   <link rel="section" href="content_arfit.html" title="arfit">
   <link rel="section" href="content_crp.html" title="crp">
   <link rel="section" href="content_crp2.html" title="crp2">
   <link rel="section" href="content_crp_big.html" title="crp_big">
   <link rel="section" href="content_crqa.html" title="crqa">
   <link rel="section" href="content_dl.html" title="dl">
   <link rel="section" href="content_entropy.html" title="entropy">
   <link rel="section" href="content_hist2.html" title="hist2">
   <link rel="section" href="content_histn.html" title="histn">
   <link rel="section" href="content_mcf.html" title="mcf">
   <link rel="section" href="content_mgui.html" title="mgui">
   <link rel="section" href="content_mi.html" title="mi">
   <link rel="section" href="content_normalize.html" title="normalize">
   <link rel="section" href="content_phasespace.html" title="phasespace">
   <link rel="section" href="content_pss.html" title="pss">
   <link rel="section" href="content_trackplot.html" title="trackplot">
   <link rel="section" href="content_tt.html" title="tt">
   <link rel="section" href="content_winplot.html" title="winplot">
   <link rel="copyright" href="http://www.pucicu.de" title="copyright">
   <link rel="author" href="http://www.pucicu.de" title="Norbert Marwan (private)">
   <link rel="search" href="http://www.google.com/search" title="Suchen">
   <script src="framecheck.js" type="text/javascript"></script>
   <script language="JavaScript">
    <!--
     
    index = parent.location.href.lastIndexOf('?')+1;
    target = "content_notes.php";
    if(index > 6)
    {
        target = parent.location.href.slice(index);
        parent.frames[1].location.href=target;
    }

    //-->
   </script>
</head>
<body bgcolor="#000000" text="#FFFFCC" link="#FFFFFF" alink="#FF0000" vlink="#FFFFCC">
<img src="http://vg07.met.vgwort.de/na/6dbc0398f2b71c0bb6f8" width="1" height="1" alt="">

<table bgcolor="#FF6666" border=0 width="100%" cellpadding=2 cellspacing=0>
<tr>
<td class=sleeptbbold height=17px>&nbsp;General Information</td>
<td class=sleeptb width=10px align=right>&nbsp;</td>
<td class=sleeptb width=10px align=right><a href="content_gpl.html"><img src="b_next.gif" border=0></a></td>
</tr></table>
<br>

<h2 align=left>CROSS RECURRENCE PLOT<br>TOOLBOX <?PHP echo $ver;?></h2>
<br>



<table><tr valign="top"><td colspan="2">

<p align="left">The toolbox contains 
<a href="http://www.mathworks.com/products/matlab/" target="_blank">MATLAB</a><sup>&#174;</sup>
routines for computing <a href="http://www.recurrence-plot.tk" target="_blank">recurrence plots</a> 
and related problems. New developments as extended recurrence quantification 
(<a href="http://dx.doi.org/10.1103/PhysRevE.66.026702" target="_blank">Marwan et al., Phys. Rev. E, 2002</a>), 
cross recurrence plots 
(<a href="http://dx.doi.org/10.1016/S0375-9601(02)01170-2" target="_blank">Marwan & Kurths, Phys. Lett. A, 2002</a>; 
<a href="http://www.copernicus.org/EGU/npg/9/325.htm" target="_blank">Marwan et al., Nonlin. Proc. Geophys., 2002</a>)
and joint recurrence plots
(<a href="http://dx.doi.org/10.1016/j.physleta.2004.07.066" target="_blank">Romano et al., Phys. Lett. A, 2004</a>)
are included.
</p>


<p>The most
programmes contain a user-friendly graphical user interface, a 
pure command-line application of the programmes is also possible.
</p>

<p>
This toolbox requires MATLAB 7 or newer.
</p>

<p>
Parameters in [&nbsp;] are optional.
</p>
<br>

</td></tr>
<tr valign="top"><td>


<table bgcolor="#FF6666" cellpadding=10 width="80%" align=center>
<tr><td>
<font color="#000000">
Starting with Release R2014b, MATLAB contains significant changes that
is causing some problems for running the CRP Toolbox in new MATLAB
versions. We have tried to fix several serious issues and
provide an updated CRP Toolbox (R29.0) that
might be mainly compatible to the MATLAB releases starting with R2014b. 
However, due to a new 
but less efficient handling of objects within MATLAB R2014b, the speed of
some functions of the CRP Toolbox will be lowered by a factor up to 10(!).
We have not yet found a good solution to speed up the code (the problem
is not the implementation of the CRP Toolbox but in some MATLAB internal
functions related to the object handling).<br><br>
At the moment it is strongly recommend to use MATLAB versions up to release 
R2014a and to avoid R2014b (and later). 
</font>
</td></tr>
</table>




<h4>How to get</h4>
<p>
Look at the <a href="content_install.php">installation notes</a>.<br>
</p>

<h4>How to contact</h4>
<p>
Get the contact information on the web site of
<a href="http://www.pik-potsdam.de/members/marwan/" target=_top>Norbert Marwan</a>.
</p>
<a href="https://twitter.com/recurrenceplot" class="twitter-follow-button" data-show-count="false">Follow @recurrenceplot</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>


<h4>Thanks</h4>
<p>
The development of is toolbox was partly supported by the
projects <em>Nonlinear Phase 
and Correlation Analysis of Palaeomagnetic and Palaeoclimatic Records</em>
within the Priority Programme SP1097 
<em>Geomagnetic variations: Spatio-temporal variations, 
processes and impacts on the system Earth</em>
of the German Science Foundation (DFG),
the project <em>BONE3D</em> (MAP AO-2004-125) of the
Microgravity Application Program/ Biotechnology from the 
Human Spaceflight Program of the European Space Agency,
and the <i>BioSim</i> Network of Excellence.

</p>

<p>Moreover, I'm especially grateful to 
Giovanna Varni (Genova, Italy),
Paolo Sirabella (Roma, Italy),
Shine Lu (Nan Jing, China),
Charles L. Webber (Chicago, USA),
Joseph P. Zbilut (Chicago, USA),
Simon Mandelj (Slovenia),
Denis Mottet (Montpellier, France), 
Micahel Wess (Vienna, Austria),
Eleni Vlahogianni (Athens, Greece),
George Tzagkarakis (Paris, France),
Arian Taghvamanesh (Tehran, Iran),
Vahndi Minah (London, UK), 
Florian Ruch (Munich, Germany), 
Mircea Stoica (Hamburg Eppendorf, Germany),
and many more
who have sent me error reports and hints for further improvement of
the toolbox.
</p>


<h4>Remarks</h4>
<p>
This toolbox needs MATLAB 7 (MATLAB 2007) or newer because it uses commands 
that are not available in previous versions. It is working with 
MATLAB 2014b, but we recommend to use a MATLAB version before this 
release because MATLAB 2014b is significantly slower than previous 
MATLAB versions.
</p>

<p>
The toolbox is still under development. We cannot give any
warranty for anything related with our programmes. Please send
error messages or comments to our contact address.<br>
</p>

<h4>Copyright</h4>

<table><tr valign="top"><td>
<a href="http://creativecommons.org/licenses/GPL/2.0/">
<img alt="CC-GNU GPL" border="0" src="http://creativecommons.org/images
/public/cc-GPL-a.png" /></a>

</td><td>

<p>
<b>&copy; <?PHP echo strftime("%Y", time()); ?> PIK Potsdam</b><br>
This toolbox is licensed under the <a href="http://creativecommons.org/licenses/GPL/2.0/">CC-GNU GPL</a>.
<!--

<rdf:RDF xmlns="http://web.resource.org/cc/"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<Work rdf:about="">
   <license rdf:resource="http://creativecommons.org/licenses/GPL/2.0/" />
   <dc:type rdf:resource="http://purl.org/dc/dcmitype/Software" />
</Work>

<License rdf:about="http://creativecommons.org/licenses/GPL/2.0/">
<permits rdf:resource="http://web.resource.org/cc/Reproduction" />
   <permits rdf:resource="http://web.resource.org/cc/Distribution" />
   <requires rdf:resource="http://web.resource.org/cc/Notice" />
   <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" />
   <requires rdf:resource="http://web.resource.org/cc/ShareAlike" />
   <requires rdf:resource="http://web.resource.org/cc/SourceCode" />
</License>

</rdf:RDF>

-->



<b>Please respect the copyrights!</b> The toolbox is protected 
by the copyright and the GPL. If you use the provided toolbox
you have to refer to the given publications 
(see the user agreement on the <a href="content_install.php">installation</a>
site).
</p>
</td></tr></table>



<h4>Future releases</h4>
<p>
We plan to improve and accelerate the toolbox routines and to 
include further methods of nonlinear data analysis.</p>

<p>
A plain <a href="http://tocsy.pik-potsdam.de/commandline-rp.php" target="_blank">commandline version</a> for creation of 
recurrence plots and RQA analysis is available for some Unix/Linux
and Dos/Windows systems.
</p>


<p>
<img src="https://badgen.net/https/tocsy.pik-potsdam.de/CRPtoolbox/ver.php" alt="Last version: <?PHP echo $ver;?>"> <img src="https://badgen.net/https/tocsy.pik-potsdam.de/CRPtoolbox/lastupdate.php" alt="Last revision: <?PHP echo $time; ?>">
</p>

<p>
<a href="https://tocsy.pik-potsdam.de/imprint.php" target="_parent">Imprint</a>,
<a href="https://tocsy.pik-potsdam.de/privacy.php" target="_parent">Privacy policy</a>,
<a href="https://tocsy.pik-potsdam.de/accessibility.php" target="_parent">Accessibility statement</a>
</p>
<br>
</td><td>

</td></tr></table>

<table bgcolor="#FF6666" width="100%" cellpadding=2 cellspacing=0 border=0>
<tr valign=middle>
<td class=sleeptb align=left width=10% height=17px>&nbsp;</td>
<td class=sleeptb align=left>&nbsp;</td>
<td class=sleeptb align=right>GNU general public license</td>
<td class=sleeptb align=right width=10% height=19px ><a href="content_gpl.html"><img src="b_next.gif" border=0></a></td>
</tr></table>

<!-- Matomo -->
<script type="text/javascript">
  var _paq = window._paq || [];
  /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
  _paq.push(["setDocumentTitle", document.domain + "/" + document.title]);
  _paq.push(["setCookieDomain", "*.tocsy.pik-potsdam.de"]);
  _paq.push(['trackPageView']);
  _paq.push(['enableLinkTracking']);
  (function() {
    var u="//tocsy.pik-potsdam.de/matomo/";
    _paq.push(['setTrackerUrl', u+'matomo.php']);
    _paq.push(['setSiteId', '2']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
  })();
</script>
<noscript><p><img src="//tocsy.pik-potsdam.de/matomo/matomo.php?idsite=2&amp;rec=1" style="border:0;" alt="" /></p></noscript>
<!-- End Matomo Code -->


<a href="https://tocsy.pik-potsdam.de/libraryexotic.php"><!-- market --></a>

</body>
</html>
