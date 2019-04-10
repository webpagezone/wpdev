<?php
	/**
	 * The template for displaying 404 pages (not found)
	 *
	 * @link https://codex.wordpress.org/Creating_an_Error_404_Page
	 *
	 * @package DevWP
	 */
	get_header();
?>
	<div id="primary" class="content-area col-md-12">
		<main id="main" class="site-main">
			<section class="error-404 not-found mt-5">
				<header class="page-header text-center">
					<h1 class="page-title display-1">
						<?php esc_html_e( '404', 'devwp' ); ?>
					</h1>
					<h2 class="display-4">
						<?php esc_html_e( 'Oops! That page can&rsquo;t be found.', 'devwp' ); ?>
					</h2>
				</header>
				<!-- .page-header -->
				<div class="page-content">
					<p class="text-center lead">
						<?php esc_html_e( 'It looks like nothing was found at this location. Maybe try one of the links below or a search?', 'devwp' ); ?>
					</p>
					
					<?php get_search_form(); ?>
					
					<div class="row mt-4">
						<div class="col-md-4">
							<?php the_widget( 'WP_Widget_Recent_Posts' ); ?>
						</div>
						<div class="col-md-4">
							<div class="widget widget_categories">
								<h2 class="widget-title">
									<?php esc_html_e( 'Most Used Categories', 'devwp' ); ?>
								</h2>
								<ul>
									<?php
										wp_list_categories( array(
											'orderby'    => 'count',
											'order'      => 'DESC',
											'show_count' => 1,
											'title_li'   => '',
											'number'     => 10,
										) );
									?>
								</ul>
							</div>
							<!-- .widget -->
						</div>
						<div class="col-md-4">
							<?php /* translators: %1$s: smiley */
								$archive_content = '<p>' . sprintf( esc_html__( 'Try looking in the monthly archives. %1$s', 'devwp' ), convert_smilies( ':)' ) ) . '</p>';
								the_widget( 'WP_Widget_Archives', 'dropdown=1', "after_title=</h2>$archive_content" );
								the_widget( 'WP_Widget_Tag_Cloud' );
							?>
						</div>
					</div>
				</div>
				<!-- .page-content -->
			</section>
			<!-- .error-404 -->
		</main>
		<!-- #main -->
	</div> <!-- #primary -->

<?php
	get_footer();