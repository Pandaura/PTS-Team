<!doctype html>
<html>
<meta http-equiv="refresh" content="25" charset="UTF-8"/>
	<meta name="description" content=""> 
	<meta name="keywords" content=""> 
	<meta name="viewport" content="width=device-width, initial-scale=0.5">
				<meta name="robots" content="noindex, nofollow, noarchive" />
                <meta http-equiv="cache-control" content="no-cache" /> 
<title>Com-UI</title>
<link rel="icon" type="image/png" href="https://i.imgur.com/T7OQsZz.png" sizes="32x32">
<style type="text/css">
body {
	background-color: #282E39;
	text-align: left;
}
.test {
}
body,td,th {
	color: #FFFFFF;
	font-size: medium;
	font-family: Segoe, "Segoe UI", "DejaVu Sans", "Trebuchet MS", Verdana, sans-serif;
}
a:link {
	color: #E8DD06;
}
a:visited {
	color: #E8DD06;
}
div {
  width: 100%;
  height: 100%;
  background-image: -webkit-linear-gradient(rgba(255, 255, 255, 0.5), rgba(255, 255, 255, 0.5)), url('https://i.imgur.com/01ueZ9g.png');
  background-size: 100% 100%;
}
</style>
</head>
  	<script type="text/javascript">
	  var message="Copyright © Coder"; 
		function taste (t) {
		if (!t)
		t = window.event;
		if ((t.type && t.type == "contextmenu") || 
		(t.button && t.button == 2) || (t.which && t.which == 3)) {
		if (window.opera)
		window.alert("Speichern nicht erlaubt.");
		return false;
		  }
		}
		if (document.layers)
		document.captureEvents(Event.MOUSEDOWN);
		 document.onmousedown = taste;
		document.oncontextmenu = taste;
	</script>
	<script language="JavaScript">
var versch = ' .... quelltext ... ';
var liste = '1234567890ß´`qwertzuiopü+#äölkjhgfds'ayx'+
            'cvbnm,.>-<*~_:;|µ!"§$%&/()=?QWERTZUIOPÜ'+
            'ÄÖLKJHGFDSAYXCVBNM@ntrbf';
function decodieren(s)
{
 s = unescape(s);
 x = prompt('Bitte Geheimzahl eingeben!'); // = 122
 res = '';
 for(i=0; i<s.length; i++)
 {
  a = s.substr(i,1);
  b = liste.indexOf(a)-x;
  while(b < 0){b = b+liste.length;}
  res += liste.substr(b,1);
 }
 return(res);
}
document.open();
document.write(decodieren(versch));
document.close();
</script> 
<body text="#FFFFFF">
<div>
<table width="100%" border="0" cellpadding="5" cellspacing="0">
  <tbody>
    <tr>
		<td width="876" align="center">
			<h1>
				<strong style="color: #000000; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: xx-large; font-weight: bolder;">Community UI<br>
					<span style="color: #053F00; font-size: small">Auto-Refreshes Every 10 Seconds</span>	
					<br>
				</strong>
			</h1>
		</td>
    </tr>
  </tbody>
</table>
</div>
<table width="100%" cellpadding="10">
  <tbody>
    <tr>
      <td height="100" valign="top">
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tbody>
            <tr>
              <td width="90%" height="30" style="color: #0FA702; font-family: 'Lucida Grande', 'Lucida Sans Unicode', 'Lucida Sans', 'DejaVu Sans', Verdana, sans-serif; font-weight: bolder; font-size: large; text-align: left;">Upload via rClone</td>
            </tr>
          </tbody>
        </table>
        <table width="100%" height="44" border="1" align="center" cellpadding="5" cellspacing="0">
          <tbody>
            <tr>
              <td colspan="6" bgcolor="#000000" style="color: #F7F6F6; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-weight: bold; font-size: medium;"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
                <?php $output = shell_exec('tail -n 25 /config/plexguide/logs/pg*.log');
echo "<pre>$output</pre>";
?>
              </span></td>
            </tr>
          </tbody>
        </table>
		<br>
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tbody>
            <tr>
              <td width="90%" height="30" style="color: #0FA702; font-family: 'Lucida Grande', 'Lucida Sans Unicode', 'Lucida Sans', 'DejaVu Sans', Verdana, sans-serif; font-weight: bolder; font-size: large; text-align: left;">rClone Logs</td>
            </tr>
          </tbody>
        </table>
        <table width="100%" height="44" border="1" align="center" cellpadding="5" cellspacing="0">
          <tbody>
            <tr>
              <td colspan="6" bgcolor="#000000" style="color: #F7F6F6; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-weight: bold; font-size: medium;">
			  <span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
                <?php $output = shell_exec('tail -n 10 /config/plexguide/logs/rclone-*.log');
echo "<pre>$output</pre>";
?>
              </span></td>
            </tr>
          </tbody>
        </table>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tbody>
            <tr>
              <td width="90%" height="30" style="color: #E11919; font-family: 'Lucida Grande', 'Lucida Sans Unicode', 'Lucida Sans', 'DejaVu Sans', Verdana, sans-serif; font-weight: bolder; font-size: large; text-align: left;"><br>
                WARNING LOG</td>
            </tr>
          </tbody>
        </table>
        <table width="100%" height="44" border="1" align="center" cellpadding="5" cellspacing="0">
          <tbody>
            <tr>
				<td colspan="6" bgcolor="#000000" style="color: #F7F6F6; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-weight: bold; font-size: medium;">
					<span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif;">
					<?php $output = shell_exec('cat /config/plexguide/emergency.log');echo "<pre>$output</pre>";?></span>
				</td>
            </tr>
          </tbody>
        </table>
        <br>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tbody>
            <tr>
              <td width="100%" height="30" style="color: #E8DD06; font-family: 'Lucida Grande', 'Lucida Sans Unicode', 'Lucida Sans', 'DejaVu Sans', Verdana, sans-serif; font-weight: bolder; font-size: large; text-align: left;">RClone | Transport & Checks</td>
            </tr>
          </tbody>
        </table>
        <table width="100%" height="44" border="1" align="center" cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
				<td width="15%" bgcolor="#000000" style="font-size: medium"><span style="color: #F7F6F6; font-weight: bold; font-size: medium;"><strong><strong>&nbsp;&nbsp;Union - RClone | Mount</strong></span></span></td>
				<td width="18%" height="21" class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif;"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
					<?php $output = shell_exec('tail -n 1 /config/plexguide/pg.union');echo "<pre>$output</pre>";?></span></td>
					
				<td width="15%" height="21" bgcolor="#000000" style="color: #F7F6F6; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-weight: bold; font-size: medium;"><strong>&nbsp;&nbsp; Blitz | Move</strong></span></span></td>
				<td width="18%" height="21" class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif;"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
					<?php $output = shell_exec('tail -n 1 /config/plexguide/pg.blitz');echo "<pre>$output</pre>";?></span></td>
					
				</tr>
				<tr>
				  <td width="15%" bgcolor="#000000" style="font-size: medium"><span style="color: #F7F6F6; font-weight: bold; font-size: medium;"><strong>&nbsp;&nbsp;/mnt/downloads</strong></span></td><td width="18%" height="21" style="font-size: medium"><span class="test" style="color: #FFFFFF;">
					<?php $output = shell_exec('tail -n1 /config/plexguide/spaceused.log');echo "<pre>$output</pre>";?></span>
				  </td>
				  <td width="15%" height="21" bgcolor="#000000" style="font-size: medium"><span style="color: #F7F6F6; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-weight: bold; font-size: medium; "><span style="color: #F7F6F6; font-weight: bold; font-size: medium;"><strong>&nbsp;&nbsp;/mnt/move</strong></span></span></td>
				  <td width="18%" height="21" style="font-size: medium"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
					<?php $output = shell_exec('head -n1 /config/plexguide/spaceused.log');echo "<pre>$output</pre>";?></span></td>
				</tr>
				<tr>
				  <td width="15%" bgcolor="#000000" style="font-size: medium"><span style="color: #F7F6F6; font-weight: bold; font-size: medium;"><strong>&nbsp;&nbsp; mergerfs </strong></span></td><td width="18%" height="21" style="font-size: medium"><span class="test" style="color: #FFFFFF;">
					<?php $output = shell_exec('tail -n 1 /config/plexguide/checkers/mergerfs.log');echo "<pre>$output</pre>";?></span>
				  </td>
				  <td width="15%" height="21" bgcolor="#000000" style="font-size: medium"><span style="color: #F7F6F6; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-weight: bold; font-size: medium; "><span style="color: #F7F6F6; font-weight: bold; font-size: medium;"><strong>&nbsp;&nbsp;rClone</strong></span></span></td>
				  <td width="18%" height="21" style="font-size: medium"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
					<?php $output = shell_exec('tail -n 1 /config/plexguide/checkers/rclone.log');echo "<pre>$output</pre>";?></span></td>
				</tr>
			</tbody>
        </table>
		<br>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0"><tbody><tr>
			<td width="90%" height="30" style="color: #E8DD06; font-family: 'Lucida Grande', 'Lucida Sans Unicode', 'Lucida Sans', 'DejaVu Sans', Verdana, sans-serif; font-weight: bolder; font-size: large; text-align: left;">
				Basic Information
			</td></tr></tbody>
        </table>
        <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0">
          <tbody>
            <tr>
              <td width="15%" bgcolor="#000000" style="font-size: medium">&nbsp;&nbsp;Edition</td>
				  <td width="18%" height="21" style="font-size: medium"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif;">
				<?php $output = shell_exec('tail -n 1 /config/plexguide/pg.transport');echo "<pre>$output</pre>" ?></span></td>
              <td width="15%" height="21" bgcolor="#000000" style="font-size: medium">&nbsp;&nbsp;Version</td>
				  <td width="18%" height="21" style="font-size: medium"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
				<?php $output = shell_exec('tail -n 1 /config/plexguide/pg.number');echo "<pre>$output</pre>";?></span></td>
              <td width="15%" bgcolor="#000000" style="font-size: medium">&nbsp;&nbsp;ServerID</td>
				<td width="18%" height="21" style="font-size: medium"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
				<?php $output = shell_exec('tail -n 1 /config/plexguide/server.id');echo "<pre>$output</pre>" ?></span></td>
            </tr>
            <tr>
              <td width="15%" bgcolor="#000000" style="font-size: medium">&nbsp;&nbsp;Traefik</td>
				<td width="18%" height="21" style="font-size: medium"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif;">
				<?php $output = shell_exec('tail -n 1 /config/plexguide/pg.traefik');echo "<pre>$output</pre>";?></span></td>
              <td width="15%" height="21" bgcolor="#000000" style="font-size: medium">&nbsp;&nbsp;GOAuth</td><td width="18%" height="21" style="font-size: medium"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
				<?php $output = shell_exec('tail -n 1 /config/plexguide/pg.oauth');echo "<pre>$output</pre>";?></span></td>
              <td width="15%" bgcolor="#000000" style="font-size: medium">&nbsp;&nbsp;PortGuard</td>
              <td width="18%" height="21" style="font-size: medium"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
				<?php $output = shell_exec('tail -n 1 /config/plexguide/pg.ports');echo "<pre>$output</pre>";?></span></td>
            </tr>
            <tr>
				<td width="15%" bgcolor="#000000" style="font-size: medium"><span style="color: #F7F6F6; font-weight: bold; font-size: medium;"><strong>&nbsp;&nbsp;OS</strong></span></td>
				<td width="18%" height="21" style="font-size: medium"><span class="test" style="color: #FFFFFF;">
				<?php $output = shell_exec('tail -n 1 /config/plexguide/pg.os');echo "<pre>$output</pre>";?></span>
				</td>
				<td width="15%" height="21" bgcolor="#000000" style="font-size: medium"><span style="color: #F7F6F6; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-weight: bold; font-size: medium; "><span style="color: #F7F6F6; font-weight: bold; font-size: medium;"><strong>&nbsp;&nbsp;Ansible</strong></span></span></td>
				<td width="18%" height="21" style="font-size: medium"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
				<?php $output = shell_exec('tail -n 1 /config/plexguide/pg.ansible');echo "<pre>$output</pre>";?></span></td>
				<td width="15%" bgcolor="#000000" style="font-size: medium"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium; font-weight: bold;"><span style="color: #F7F6F6; font-weight: bold; font-size: medium;"><strong> &nbsp;&nbsp;Used Space</strong></span></span></td>
				<td width="18%" height="21" style="font-size: medium"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
				<?php $output = shell_exec('tail -n 1 /config/plexguide/pg.used');echo "<pre>$output</pre>" ?></span></td>
            </tr>
            <tr>
              <td width="15%" bgcolor="#000000" style="font-size: medium"><span style="color: #F7F6F6; font-weight: bold; font-size: medium;"><strong>&nbsp; GCE</strong></span></td><td width="18%" height="21" style="font-size: medium"><span class="test" style="color: #FFFFFF;">
				<?php $output = shell_exec('tail -n 1 /config/plexguide/pg.gce');echo "<pre>$output</pre>";?></span>
			  </td>
              <td width="15%" height="21" bgcolor="#000000" style="font-size: medium"><span style="color: #F7F6F6; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-weight: bold; font-size: medium; "><span style="color: #F7F6F6; font-weight: bold; font-size: medium;"><strong>&nbsp;&nbsp;Docker</strong></span></span></td>
              <td width="18%" height="21" style="font-size: medium"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
                <?php $output = shell_exec('tail -n 1 /config/plexguide/pg.docker');echo "<pre>$output</pre>";?></span></td>
              <td width="15%" bgcolor="#000000" style="font-size: medium"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium; font-weight: bold;"><span style="color: #F7F6F6; font-weight: bold; font-size: medium;"><strong>&nbsp;&nbsp;Disk Space</strong></span></span></td>
              <td width="18%" height="21" style="font-size: medium"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
                <?php $output = shell_exec('tail -n 1 /config/plexguide/pg.capacity');echo "<pre>$output</pre>";?></span></td>
            </tr>
          </tbody>	
        </table>		  
		<br>
		<!--added -->
		<!-- <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			  <tbody>
				<tr>
				  <td width="100%" height="30" style="color: #E8DD06; font-family: 'Lucida Grande', 'Lucida Sans Unicode', 'Lucida Sans', 'DejaVu Sans', Verdana, sans-serif; font-weight: bolder; font-size: large; text-align: left;"> More Informations </td>
				</tr>
			  </tbody>
			</table>
		<table width="100%" height="60" border="1" align="center" cellpadding="0" cellspacing="0">
		<tbody>
		</table> */ -->
		<br>
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			  <tbody>
				<tr>
				  <td width="100%" height="30" style="color: #E8DD06; font-family: 'Lucida Grande', 'Lucida Sans Unicode', 'Lucida Sans', 'DejaVu Sans', Verdana, sans-serif; font-weight: bolder; font-size: large; text-align: left;">GDrive Section</td>
				</tr>
			  </tbody>
			</table>
			<table width="100%" height="40" border="1" align="center" cellpadding="0" cellspacing="0"><tbody> <!--// GDRIVE --><tr>
					<td width="15%" bgcolor="#000000" style="font-size: medium"><strong>&nbsp;&nbsp;GDrive - RClone | Mount</strong></span></td>
					<td width="18%" height="21" class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
						<?php $output = shell_exec('tail -n 1 /config/plexguide/pg.gdrive');echo "<pre>$output</pre>";?></span></td>
					<td width="15%" bgcolor="#000000" style="font-size: medium"><strong>&nbsp;&nbsp;GCrypt - RClone | Mount</strong></span></td>
					<td width="18%" height="21" class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
						<?php $output = shell_exec('tail -n 1 /config/plexguide/pg.gcrypt');echo "<pre>$output</pre>";?></span></td>
				</tr></tbody>			
			</table>
			<br>
			<table width="100%" height="40" border="1" align="center" cellpadding="0" cellspacing="0"><tbody> <!--// GDRIVE --><tr>
					<td width="15%" bgcolor="#000000" style="font-size: medium"><span style="color: #F7F6F6; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-weight: bold; font-size: medium;"><strong>&nbsp;&nbsp;GDrive /wo Encryption</strong></span></td>
					<td width="18%" height="21" class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif;"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
						<?php $output = shell_exec('tail -n1 /config/plexguide/gduncrypt.log');echo "<pre>$output</pre>";?></span></td>
					<td width="15%" bgcolor="#000000" style="font-size: medium"><strong>&nbsp;&nbsp;GDrive /w Encyption</strong></span></td>
					<td width="18%" height="21" class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
						<?php $output = shell_exec('tail -n1 /config/plexguide/gdcrypt.log');echo "<pre>$output</pre>";?></span></td>
				</tbody></tr>			
			</table>
			<table width="100%" height="40" border="1" align="center" cellpadding="0" cellspacing="0"><tbody> <!--// GDRIVE --><tr>
					<td width="15%" bgcolor="#000000" style="font-size: medium"><strong>&nbsp;&nbsp;GDrive /wo Encryption files/folder</strong></span></td>
					<td width="18%" height="21" class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif;"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
						<?php $output = shell_exec('tail -n2 /config/plexguide/gduncrypt.log | head -1');echo "<pre>$output</pre>";?></span></td>
					<td width="15%" bgcolor="#000000" style="font-size: medium"><strong>&nbsp;&nbsp;GDrive /w Encyption file/folders</strong></span></td>
					<td width="18%" height="21" class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
						<?php $output = shell_exec('tail -n2 /config/plexguide/gdcrypt.log | head -1');echo "<pre>$output</pre>";?></span></td>
				</tr></tbody>			
			</table>
		<br>
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			  <tbody>
				<tr>
				  <td width="100%" height="30" style="color: #E8DD06; font-family: 'Lucida Grande', 'Lucida Sans Unicode', 'Lucida Sans', 'DejaVu Sans', Verdana, sans-serif; font-weight: bolder; font-size: large; text-align: left;">TDrive Section</td>
				</tr>
			  </tbody>
			</table>
			<table width="100%" height="40" border="1" align="center" cellpadding="0" cellspacing="0">
			<tbody> <!--// TDRIVE -->
				<tr>
						<td width="15%" bgcolor="#000000" style="font-size: medium"><strong> &nbsp;&nbsp;TDrive - RClone | Mount</strong></span></td>
						<td width="18%" height="21" class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
							<?php $output = shell_exec('tail -n 1 /config/plexguide/pg.tdrive');echo "<pre>$output</pre>";?></span></td>
						<td width="15%" bgcolor="#000000" style="font-size: medium"><strong>&nbsp;&nbsp;TCrypt - RClone | Mount</strong></span></td>
						<td width="18%" height="21" class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
							<?php $output = shell_exec('tail -n 1 /config/plexguide/pg.tcrypt');echo "<pre>$output</pre>";?></span></td>
				</tr>
			</tbody>			
			</table>
			<br>
			<table width="100%" height="42" border="1" align="center" cellpadding="0" cellspacing="0"><tbody>
						<td width="15%" bgcolor="#000000" style="font-size: medium"><strong> &nbsp;&nbsp;TDrive /wo Encryption</strong></span></td>
						<td width="18%" height="21" class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
							<?php $output = shell_exec('tail -n1 /config/plexguide/tduncrypt.log');echo "<pre>$output</pre>";?></td>
						<td width="15%" bgcolor="#000000" style="font-size: medium"><strong> &nbsp;&nbsp;TDrive /w Encryption</strong></span></td>
						<td width="18%" height="21" class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
							<?php $output = shell_exec('tail -n1 /config/plexguide/tdcrypt.log');echo "<pre>$output</pre>";?></td>			
				</tr></tbody>			
			</table>
			<table width="100%" height="42" border="1" align="center" cellpadding="0" cellspacing="0"><tbody>
						<td width="15%" bgcolor="#000000" style="font-size: medium"><strong> &nbsp;&nbsp;TDrive /wo Encryption files/folders</strong></span></td>
						<td width="18%" height="21" class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
							<?php $output = shell_exec('tail -n2 /config/plexguide/tduncrypt.log | head -1');echo "<pre>$output</pre>";?></span></td>
						<td width="15%" bgcolor="#000000" style="font-size: medium"><strong> &nbsp;&nbsp;TDrive /w Encryption files/folders</strong></span></td>
						<td width="18%" height="21" class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
							<?php $output = shell_exec('tail -n2 /config/plexguide/tdcrypt.log | head -1');echo "<pre>$output</pre>";?></span></td>
				</tr></tbody>			
			</table>
				</tr>
					<!--added -->				
		</tbody>
                </ol>
            </tr>
          </tbody>
      </td>
    </tr>
  </tbody>
</table>
</body>
</html>
