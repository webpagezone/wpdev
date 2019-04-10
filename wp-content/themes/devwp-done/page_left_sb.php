<?php
	/**
	 * Template Name: Left Sidebar Page
	 *
	 * This is the template that displays without sidebars
	 *
	 * @link https://codex.wordpress.org/Template_Hierarchy
	 *
	 * @package DevWP
	 */

	get_header();
?>

	<div id="primary" class="content-area col-md-8 order-md-2">
		<main id="main" class="site-main theiaStickySidebar">
			<?php
				while ( have_posts() ): the_post();

					get_template_part( 'template-parts/content', 'page' );

					if ( comments_open() || get_comments_number() ):
						comments_template();
					endif;

				endwhile; // End of the loop.
			?>
		</main>
		<!-- #main -->
	</div> <!-- #primary -->
<?php
	get_sidebar( 'left' );
	get_footer();
