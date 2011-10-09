<?php
$file_name = $_FILES["fileUpload"]["tmp_name"];
$username = $_POST['username'];
$email = $_POST['email'];
if($file_name){
	$image_original_name = "image_original.jpg";
	move_uploaded_file($file_name,$image_original_name);
	$width=200; // Fix Width & Heigh (Autu caculate)
	$size=GetimageSize($image_original_name);
	$height=round($width*$size[1]/$size[0]);
	$images_orig = ImageCreateFromJPEG($image_original_name);
	$photoX = ImagesX($images_orig);
	$photoY = ImagesY($images_orig);
	$images_fin = ImageCreateTrueColor($width, $height);
	ImageCopyResampled($images_fin, $images_orig, 0, 0, 0, 0, $width+1, $height+1, $photoX, $photoY);
	ImageJPEG($images_fin,"image_resize.jpg");
	ImageDestroy($images_orig);
	ImageDestroy($images_fin);
}
if($username){
	$objFopen = fopen("username.txt", 'w');
	fwrite($objFopen, $username);
	fclose($objFopen);
}
if($email){
	$objFopen = fopen("email.txt", 'w');
	fwrite($objFopen, $email);
	fclose($objFopen);
}
?>
<html>
<head>
<title>Test Upload</title>
</head>
<body>
<form action="./" method="post" enctype="multipart/form-data">
username : <input name="username"><br>
email : <input name="email"><br>
<input name="fileUpload" type="file"><br>
<input type="submit" name="Submit" value="Submit">
</form>
username : <?php echo file_get_contents("username.txt"); ?><br>
email : <?php echo file_get_contents("email.txt"); ?><br>
<img src="image_resize.jpg?time=<?php echo time(); ?>">
</body>
</html>
