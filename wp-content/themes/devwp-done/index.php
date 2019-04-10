<?php
	/**
	 * The main template file
	 *
	 * This is the most generic template file in a WordPress theme
	 * and one of the two required files for a theme (the other being style.css).
	 * It is used to display a page when nothing more specific matches a query.
	 * E.g., it puts together the home page when no home.php file exists.
	 *
	 * @link https://developer.wordpress.org/themes/basics/template-hierarchy/
	 *
	 * @package DevWP
	 */
	get_header();
	$devwp_sidebar_options = get_theme_mod( 'devwp_sidebar_options' );
	
	if ( $devwp_sidebar_options == 'right' || $devwp_sidebar_options == 'left' ) {
		?>
		<div id="primary" class="content-area col-md-8 <?php if ( 'left' == $devwp_sidebar_options ) {
			echo ' order-md-2';
		} ?>">
		<main id="main" class="site-main theiaStickySidebar">
	<?php } elseif ( $devwp_sidebar_options == 'none' ) { ?>
		<div id="primary" class="content-area col-md-12">
		<main id="main" class="site-main">
	<?php }
	
	if ( have_posts() ):
		if ( is_home() && ! is_front_page() ):
			?>
			<header>
				<h1 class="page-title screen-reader-text">
					<?php
						single_post_title();
					?>
				</h1>
			</header>
		<?php
		endif;
		/* Start the Loop */
		while ( have_posts() ):
			the_post();
			/*
	   * Include the Post-Format-specific template for the content.
	   * If you want to override this in a child theme, then include a file
	   * called content-___.php (where ___ is the Post Format name) and that will be used instead.
	   */
			get_template_part( 'template-parts/content', get_post_format() );
		endwhile;
		
		if ( is_active_sidebar( 'below-content' ) ): ?>
			<div class="below-content">
				<?php dynamic_sidebar( 'below-content' ); ?>
			</div>
			<hr>
		<?php endif;
		the_posts_pagination( array(
			'mid_size'  => 2,
			'prev_text' => __( 'Back', 'devwp' ),
			'next_text' => __( 'Onward', 'devwp' ),
		) );
	else:
		get_template_part( 'template-parts/content', 'none' );
	endif;
?>
	</main>
	<!-- #main -->
	</div>
	<!-- #primary -->
<?php
	if ( $devwp_sidebar_options == 'right' ) {
		get_sidebar();
	} elseif ( $devwp_sidebar_options == 'left' ) {
		get_sidebar( 'left' );
	}
	get_footer();