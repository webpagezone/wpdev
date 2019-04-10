<?php
	/**
	 * The template for displaying search results pages
	 *
	 * @link https://developer.wordpress.org/themes/basics/template-hierarchy/#search-result
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
	if ( have_posts() ): ?>

		<header class="page-header">
			<h1 class="page-title">
				<?php
					/* translators: %s: search query. */
					printf( esc_html__( 'Search Results for: %s', 'devwp' ), '<span>' . get_search_query() . '</span>' );
				?>
			</h1>
		</header>
		<!-- .page-header -->

		<?php
		/* Start the Loop */
		while ( have_posts() ): the_post();

			/**
			 * Run the loop for the search to output the results.
			 * If you want to overload this in a child theme then include a file
			 * called content-search.php and that will be used instead.
			 */
			get_template_part( 'template-parts/content', 'search' );
			echo "<hr>";
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
	</div>

<?php
	if ( $devwp_sidebar_options == 'right' ) {
		get_sidebar();
	} elseif ( $devwp_sidebar_options == 'left' ) {
		get_sidebar( 'left' );
	}
	get_footer();
