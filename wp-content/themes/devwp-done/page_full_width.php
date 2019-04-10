<?php
	/**
	 * Template Name: Full Width Page
	 *
	 * This is the template that displays without sidebars
	 *
	 * @link https://codex.wordpress.org/Template_Hierarchy
	 *
	 * @package DevWP
	 */

	get_header();
?>

	<div id="primary" class="content-area col-md-12">
		<main id="main" class="site-main">

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
	get_footer();
