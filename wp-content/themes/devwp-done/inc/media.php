<?php
// This file contains php code related to images and video

// Responsive Video Embed Code

	add_filter( 'embed_oembed_html', 'devwp_wrap_embed_with_div', 10, 3 );

	function devwp_wrap_embed_with_div( $html ) {
		// Native Bootstrap responsive class is:
		// embed-responsive embed-responsive-16by9
		return '<div class="responsive-container">' . $html . '</div>';
		// return '<div class="embed-responsive embed-responsive-16by9">' . $html . '</div>';
	}

	/* Automatically set the image Title, Alt-Text, Caption & Description upon upload
  --------------------------------------------------------------------------------------*/
	add_action( 'add_attachment', 'devwp_default_image_meta_on_upload' );

	function devwp_default_image_meta_on_upload( $post_ID ) {
		// global $post;
		// Check if uploaded file is an image, else do nothing

		if ( wp_attachment_is_image( $post_ID ) ) {

			$default_image_title = get_post( $post_ID )->post_title;

			// Sanitize the title:  remove hyphens, underscores & extra spaces:
			$default_image_title = preg_replace( '%\s*[-_\s]+\s*%', ' ', $default_image_title );

			// Sanitize the title:  capitalize first letter of every word (other letters lower case):
			$default_image_title = ucwords( strtolower( $default_image_title ) );

			// Create an array with the image meta information (Title, Caption, Description) to be updated
			// Note:  You can comment out the excerpt or content sections below if you don't need it.
			$default_image_meta = array(
				'ID'           => $post_ID,
				// Specify the image (ID) to be updated
				'post_title'   => $default_image_title,
				// Set image Title to sanitized title
				//				'post_excerpt' => $default_image_title,
				// Set image Caption (Excerpt) to sanitized title
				'post_content' => $default_image_title,
				// Set image Description (Content) to sanitized title
			);

			// Set the image Alt-Text
			update_post_meta( $post_ID, '_wp_attachment_image_alt', $default_image_title );

			// Set the image meta (e.g. Title, Excerpt, Content)
			wp_update_post( $default_image_meta );

		}
	}

// thumbnails in posts admin column
	if ( ! function_exists( 'devwp_add_thumb_column' ) && function_exists( 'add_theme_support' ) ) {
		add_theme_support( 'post-thumbnails', array( 'post', 'page' ) );

		function devwp_add_thumb_column( $cols ) {
			$cols[ 'thumbnail' ] = __( 'Thumbnail', 'devwp' );

			return $cols;
		}

		function devwp_add_thumb_value( $column_name, $post_id ) {
			$width  = 40;
			$height = 40;

			if ( 'thumbnail' == $column_name ) {
				$thumbnail_id = get_post_meta( $post_id, '_thumbnail_id', true );

				$attachments = get_children( array(
					'post_parent'    => $post_id,
					'post_type'      => 'attachment',
					'post_mime_type' => 'image'
				) );


				if ( $thumbnail_id ) {
					$thumb = wp_get_attachment_image( $thumbnail_id, array(
						$width,
						$height
					), true );
				} elseif ( $attachments ) {
					foreach ( $attachments as $attachment_id => $attachment ) {
						$thumb = wp_get_attachment_image( $attachment_id, array(
							$width,
							$height
						), true );
					}
				}
				if ( isset( $thumb ) && $thumb ) {
					echo $thumb;
				} else {
					echo __( 'None', 'devwp' );
				}
			}
		}

		add_filter( 'manage_posts_columns', 'devwp_add_thumb_column' );
		add_action( 'manage_posts_custom_column', 'devwp_add_thumb_value', 10, 2 );

		add_filter( 'manage_pages_columns', 'devwp_add_thumb_column' );
		add_action( 'manage_pages_custom_column', 'devwp_add_thumb_value', 10, 2 );
	}

	// Post Thumbnail Feature
	if ( ! function_exists( 'devwp_post_thumbnail' ) ):
		/**
		 * Displays an optional post thumbnail.
		 *
		 * Wraps the post thumbnail in an anchor element on index views, or a div
		 * element when on single views.
		 */
		function devwp_post_thumbnail() {
			$containerType = get_theme_mod( 'devwp_container_type' );
//			$devwp_sidebar_options = get_theme_mod( 'devwp_sidebar_options' );
			if ( post_password_required() || is_attachment() || ! has_post_thumbnail() ) {
				return;
			}
			if ( is_singular() ):
				?>

				<div class="post-thumbnail">
					<?php
						if ( 'container' == $containerType ) {
							the_post_thumbnail( 'large-thumb' );
						} elseif ( 'container-fluid' == $containerType ) {
							the_post_thumbnail( 'xl-thumb' );
						}
					?>
				</div> <!-- .post-thumbnail -->

			<?php else : ?>

				<a class="post-thumbnail" href="<?php the_permalink(); ?>" aria-hidden="true" tabindex="-1">
					<?php
						if ( 'container' == $containerType ) {
							the_post_thumbnail( 'large-thumb', array(
								'alt' => the_title_attribute( array(
									'echo' => false,
								) ),
							) );
						} elseif ( 'container-fluid' == $containerType ) {
							the_post_thumbnail( 'xl-thumb', array(
								'alt' => the_title_attribute( array(
									'echo' => false,
								) ),
							) );
						}

					?> </a>

			<?php
			endif; // End is_singular().
		}
	endif;

	// default featured image code. Comment out when distributed.
	// function dfi_category( $dfi_id, $post_id ) {
	// 	// all which have 'wordpress' as a category
	// 	if ( has_category( 'wordpress', $post_id ) ) {

	// 		return 80; // the id of the image you want to use
	// 	}

	// 	return $dfi_id; // the original featured image id
	// }

	// add_filter( 'dfi_thumbnail_id', 'dfi_category', 10, 2 );

	//Different image for the post_type 'page'

	// function dfi_posttype_page( $dfi_id, $post_id ) {
	// 	$post = get_post( $post_id );
	// 	if ( 'page' === $post->post_type && $post_id == 11 ) {
	// 		return 88; // the image id
	// 	} elseif ( 'page' === $post->post_type && $post_id == 12 ) {
	// 		return 81; // the image id
	// 	} elseif ( 'page' === $post->post_type && $post_id == 13 ) {
	// 		return 79; // the image id
	// 	} elseif ( 'page' === $post->post_type && $post_id == 14 ) {
	// 		return 82; // the image id
	// 	} elseif ( 'page' === $post->post_type && $post_id == 15 ) {
	// 		return 89; // the image id
	// 	} elseif ( 'page' === $post->post_type && $post_id == 16 ) {
	// 		return 90; // the image id
	// 	} elseif ( 'page' === $post->post_type && $post_id == 18 ) {
	// 		return 92; // the image id
	// 	} elseif ( 'page' === $post->post_type && $post_id == 28 ) {
	// 		return 93; // the image id
	// 	} elseif ( 'page' === $post->post_type && $post_id == 29 ) {
	// 		return 91; // the image id
	// 	}

	// 	return $dfi_id; // the original featured image id
	// }

	// add_filter( 'dfi_thumbnail_id', 'dfi_posttype_page', 10, 2 );

	// // Don't use default featured image on these pages
	// function dfi_skip_page( $dfi_id, $post_id ) {
	// 	if ( $post_id == 231 || $post_id == 216 || $post_id == 249 ) {
	// 		return 0; // invalid id
	// 	}

	// 	return $dfi_id; // the original featured image id
	// }

	// add_filter( 'dfi_thumbnail_id', 'dfi_skip_page', 10, 2 );
