<?php
	/*
   *  Template Name: Left Sidebar Template
   *  Template Post Type: post
   *  @package DevWP
   */
	get_header();
?>
	<div id="primary" class="content-area col-md-8 order-md-2">
		<main id="main" class="site-main theiaStickySidebar">

			<?php
					while ( have_posts() ): the_post();
						get_template_part( 'template-parts/content', get_post_type() );
						if ( is_active_sidebar( 'below-content' ) ):
			?>
						<div class="widget-area">
							<?php dynamic_sidebar( 'below-content' ); ?>
						</div>
						<hr>

			<?php endif;
						$args = array(
							'prev_text'          => '&larr; Previous Post: %title',
							'next_text'          => 'Next Post: %title 	&rarr;',
							'screen_reader_text' => 'Post Navigation'
						);
						the_post_navigation( $args );
						if ( comments_open() || get_comments_number() ):
							comments_template();
						endif;
					endwhile; // End of the loop.
			?>
		</main>
	</div>
<?php
	get_sidebar( 'left' );
	get_footer();
