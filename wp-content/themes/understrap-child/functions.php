<?php

/**
 * Storefront automatically loads the core CSS even if using a child theme as it is more efficient
 * than @importing it in the child theme style.css file.
 *
 * Uncomment the line below if you'd like to disable the Storefront Core CSS.
 *
 * If you don't plan to dequeue the Storefront Core CSS you can remove the subsequent line and as well
 * as the sf_child_theme_dequeue_style() function declaration.
 */
//add_action( 'wp_enqueue_scripts', 'sf_child_theme_dequeue_style', 999 );

/**
 * Dequeue the Storefront Parent theme core CSS
 */
function sf_child_theme_dequeue_style() {
    wp_dequeue_style( 'shop-isle-style' );
    wp_dequeue_style( 'shop-isle-woocommerce-style' );
}


/**
 * Display the custom text field
 * @since 1.0.0
 */
function cfwc_create_custom_field() {
 $args = array(
 'id' => 'custom_text_field_title',
 'label' => __( 'Custom Text Field Title', 'cfwc' ),
 'class' => 'cfwc-custom-field',
 'desc_tip' => true,
 'description' => __( 'Enter the title of your custom text field.', 'ctwc' ),
 );
 woocommerce_wp_text_input( $args );
}
add_action( 'woocommerce_product_options_general_product_data', 'cfwc_create_custom_field' );
/**
 * Note: DO NOT! alter or remove the code above this text and only add your custom PHP functions below this text.
 */

/**
 * Save the custom field
 * @since 1.0.0
 */
function cfwc_save_custom_field( $post_id ) {
 $product = wc_get_product( $post_id );
 $title = isset( $_POST['custom_text_field_title'] ) ? $_POST['custom_text_field_title'] : '';
 $product->update_meta_data( 'custom_text_field_title', sanitize_text_field( $title ) );
 $product->save();
}
add_action( 'woocommerce_process_product_meta', 'cfwc_save_custom_field' );

/**
 * Display custom field on the front end
 * @since 1.0.0
 */
function cfwc_display_custom_field() {
 global $post;
 // Check for the custom field value
 $product = wc_get_product( $post->ID );
 $title = $product->get_meta( 'custom_text_field_title' );
 if( $title ) {
 // Only display our field if we've got a value for the field title
 printf(
 '<div class="cfwc-custom-field-wrapper"><label for="cfwc-title-field">%s</label><input type="text" id="cfwc-title-field" name="cfwc-title-field" value=""></div>',
 esc_html( $title )
 );
 }
}
add_action( 'woocommerce_before_add_to_cart_button', 'cfwc_display_custom_field' );
