<?php
	/**
	 * The template for displaying archive pages
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
		?>
		<header class="page-header">
			<?php
				the_archive_title( '<h1 class="page-title">', '</h1>' );
				the_archive_description( '<div class="archive-description">', '</div>' );
			?>
		</header>
		<!-- .page-header -->
		<?php
		/* Start the Loop */
		while ( have_posts() ): the_post();
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

	else :
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
