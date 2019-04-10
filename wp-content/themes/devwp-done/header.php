<?php
	/**
	 * The header for our theme
	 *
	 * This is the template that displays all of the <head> section and everything up until <div id="content">
	 *
	 * @link    https://developer.wordpress.org/themes/basics/template-files/#template-partials
	 *
	 * @package DevWP
	 */
	
	$containerType = get_theme_mod( 'devwp_container_type' );
	$navbarType    = get_theme_mod( 'devwp_navbar_type' );

?>
	<!doctype html>
<html <?php language_attributes(); ?>>
	
	<head>
		<meta charset = "<?php bloginfo( 'charset' ); ?>">
		<meta name = "viewport" content = "width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name = "mobile-web-app-capable" content = "yes">
		<meta name = "apple-mobile-web-app-capable" content = "yes">
		<meta name = "apple-mobile-web-app-title"
		      content = "<?php bloginfo( 'name' ); ?> - <?php bloginfo( 'description' ); ?>">

		<link rel = "profile" href = "http://gmpg.org/xfn/11">
		
		<?php wp_head(); ?>
	</head>

<body <?php body_class(); ?>>
<div id = "page" class = "site">
	<a class = "skip-link screen-reader-text" href = "#content">
		<?php esc_html_e( 'Skip to content', 'devwp' ); ?>
	</a>
	
	<header id = "masthead" class = "site-header <?php echo devwp_has_header(); ?>">
		<nav id = "menu" class = "navbar navbar-expand-lg <?php if ( 'fixed-top' == $navbarType || 'offcanvas' == $navbarType ) {
			echo 'fixed-top';
		} ?> navbar-dark">

			<?php if ( 'container' == $containerType ) : ?>
			<div class = "container">
				<?php endif; ?>
				<div class = "site-branding navbar-brand">
					<?php
						the_custom_logo();
						if ( is_front_page() || is_home() ): ?>
							<h1 class = "site-title"><a
									href = "<?php echo esc_url( home_url( '/' ) ); ?>"
									rel = "home"><?php bloginfo( 'name' ); ?></a></h1>
						<?php else : ?>
							<p class = "site-title">
								<a href = "<?php echo esc_url( home_url( '/' ) ); ?>" rel = "home">
									<?php bloginfo( 'name' ); ?>
								</a>
							</p>
						<?php
						endif;
						
						$description = get_bloginfo( 'description', 'display' );
						if ( $description || is_customize_preview() ): ?>
							<p class = "site-description">
								<?php echo $description; /* WPCS: xss ok. */ ?>
							</p>
						<?php
						endif;
					?>
				</div>
				<!-- .site-branding -->
				<?php if ( 'offcanvas' == $navbarType ) { ?>
				<button class = "navbar-toggler p-0" type = "button" data-toggle = "offcanvas"
				        data-target = "#bs4navbar" aria-controls = "bs4navbar" aria-expanded = "false"
				        aria-label = "Toggle navigation">
					<span class = "navbar-toggler-icon"></span>
				</button>

				<?php } else { ?>
					<button class = "navbar-toggler navbar-toggler-right" type = "button" data-toggle = "collapse"
				        data-target = "#bs4navbar" aria-controls = "bs4navbar" aria-expanded = "false"
				        aria-label = "Toggle navigation">
					<span class = "navbar-toggler-icon"></span>
				</button>
				<?php } ?>
				
				<?php
				if ( 'offcanvas' == $navbarType ) {
					$offcanvas = 'navbar-collapse offcanvas-collapse';
				} else {
					$offcanvas = 'collapse navbar-collapse';
				}
					wp_nav_menu( [
						'menu'            => 'primary',
						'theme_location'  => 'primary',
						'depth'           => 2,
						'container'       => 'div',
						'container_id'    => 'bs4navbar',
						'container_class' => $offcanvas,
						'menu_class'      => 'navbar-nav ml-auto',
						'fallback_cb'     => 'WP_Bootstrap_Navwalker::fallback',
						'walker'          => new bs4navwalker()
					] );
					if ( 'container' == $containerType ): ?>
			</div>
			<!-- .container -->
		<?php endif; ?>
		</nav>

	</header>
	<!-- #masthead -->

<?php
if ( is_front_page() && ! is_home() ) :
// https://developer.wordpress.org/reference/functions/has_custom_header/
// https://developer.wordpress.org/reference/functions/has_header_video/
	if ( has_header_video() ) : ?>
		<?php // https://youtu.be/pEJ2IzYOx5c
		//  https://youtu.be/fxIlVbvOHyY
		if ( 'fixed-top' == $navbarType || 'offcanvas' == $navbarType ) : ?>
			<div class = "mt-6">
		<?php endif;
// https://developer.wordpress.org/reference/functions/the_custom_header_markup/
		the_custom_header_markup();
		
		if ( 'fixed-top' == $navbarType || 'offcanvas' == $navbarType ) : ?>
			</div>
		<?php endif;

// https://developer.wordpress.org/reference/functions/has_header_image/
	elseif ( has_header_image() ) : ?>
		
		<div class = "header-image d-flex justify-content-center align-items-center <?php
			if ( 'fixed-top' == $navbarType || 'offcanvas' == $navbarType ) {
				echo 'mt-6';
			} ?>">
			<?php devwp_header_text(); ?>
			<img src = "<?php header_image(); ?>" width = "<?php echo esc_attr( get_custom_header() -> width ); ?>"
			     alt = "<?php bloginfo( 'name' ); ?>">
		</div>
	
	<?php endif;
	
	$ffesb = is_active_sidebar( 'front-full-edge' );
	$ffcsb = is_active_sidebar( 'front-full-centered' );
	if ( $ffesb ) : ?>
		<div
			class = "d-flex justify-content-center <?php if ( 'fixed-top' == $navbarType && ! has_custom_header() ) {
				echo 'mt-6';
			} else {echo 'mt-1';} ?>">
			<?php dynamic_sidebar( 'front-full-edge' ); ?>
		</div>
	
	<?php endif; ?>
	
	<div class = "fp <?php echo esc_attr( $containerType );
		if ( 'fixed-top' == $navbarType && ! has_custom_header() ) {
			echo ' mt-7';
		} else {
			echo ' mt-2';
		} ?>">
<?php endif;

if ( is_home() ) :
if ( is_active_sidebar( 'home-full-edge' ) ) : ?>
	<div
		class = "header-image d-flex justify-content-center align-items-center <?php if ( 'fixed-top' == $navbarType || 'offcanvas' == $navbarType ) {
			echo 'mt-6';
		} ?>">
		<?php devwp_header_blog();
			dynamic_sidebar( 'home-full-edge' ); ?>
	</div>
	
	<div class = "hp1 <?php echo esc_attr( $containerType ); ?>">
	
	<?php else : ?>
	
	<div class = "hp2 <?php echo esc_attr( $containerType );
		if ( 'fixed-top' == $navbarType ) {
			echo ' mt-7';
		} ?>">

<?php endif;
endif;
	
	if ( ! is_front_page() && ! is_home() ) : ?>
	<div class = "<?php echo esc_attr( $containerType ); ?> ">
	<div id = "content" class = "site-content row <?php if ( 'fixed-top' == $navbarType || 'offcanvas' == $navbarType ) {
		echo ' mt-7';
	} else {
		echo 'mt-3';
	} ?>">
	<?php endif;
