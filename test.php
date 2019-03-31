<!DOCTYPE html>
<html>
<body>

<?php

$userdata = arry(
	'user_pass' =>  'KO03gT7@n*', 
	 'user_nicename' => 'Brian',        
	 'user_url'      => 'http://webdevstudios.com/',        
	 'user_email'    => 'brian@schoolpress.me',  
	 'display_name'  => 'Brian',        
	 'nickname'      => 'Brian',        
	 'first_name'    => 'Brian',        
	 'last_name'     => 'Messenlehner',       
	 'description'   => 'This is a SchoolPress Administrator account.',        
	 'role'          => 'administrator' 
);

wp_insert_user( $userdata ); 

// create users 
wp_create_user( 'jason', 'YR529G%*v@', 'jason@schoolpress.me' );

//get user by login

$user = get_user_by( 'login', 'brian' );

echo 'email: ' . $user->user_email;
?>
</body>
</html>