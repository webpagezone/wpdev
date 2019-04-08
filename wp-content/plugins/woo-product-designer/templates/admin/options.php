<?php

$meatFrontend = array(
					'allowed-types'	=> array(	'label'		=> __('Design button title', 'nm-wcpd'),
						'desc'		=> __('', 'nm-wcpd'),
						'id'			=> $this->plugin_meta['shortname'].'_btn_title',
						'type'			=> 'text',
						'default'		=> '',
						'help'			=> __('Enter text for product design button(default: Design Product)', 'nm-wcpd')
					),

					'btn-font-color'	=> array(	'label'		=> __('Button font color', 'nm-wcpd'),
						'desc'		=> __('', 'nm-wcpd'),
						'id'			=> $this->plugin_meta['shortname'].'_font_color',
						'type'			=> 'color',
						'default'		=> '#fffeee',
						'help'			=> __('Select font color', 'nm-wcpd')
					),

					'btn-bg-color'	=> array(	'label'		=> __('Button background color', 'nm-wcpd'),
						'desc'		=> __('', 'nm-wcpd'),
						'id'			=> $this->plugin_meta['shortname'].'_bg_color',
						'type'			=> 'color',
						'default'		=> '#fffeee',
						'help'			=> __('Select background color', 'nm-wcpd')
					),

					'canvas-size'	=> array(	'label'		=> __('Canvas size', 'nm-wcpd'),
						'desc'		=> __('', 'nm-wcpd'),
						'id'			=> $this->plugin_meta['shortname'].'_canvas_size',
						'type'			=> 'text',
						'help'			=> __('Select canvas size(default: 500)', 'nm-wcpd')
					),

					'canvas-grid'	=> array(
						'label'		=> __('Disable Grid', 'nm-wcpd'),
						'desc'		=> __('', 'nm-wcpd'),
						'id'			=> $this->plugin_meta['shortname'].'_disable_grid',
						'type'			=> 'checkbox',
						'options'			=> array('disable' => __( 'Disable', 'nm-wcpd' )),
						'help'			=> __('Check to disable grid on canvas', 'nm-wcpd')
					),

					'custom-fonts'	=> array(
						'label'		=> __('Custom Fonts', 'nm-wcpd'),
						'desc'		=> __('', 'nm-wcpd'),
						'id'			=> $this->plugin_meta['shortname'].'_custom_fonts',
						'type'			=> 'textarea',
						'help'			=> __('Provide additional font families, each per line. Fonts must be installed on the site', 'nm-wcpd')
					),
				);




$this -> the_options = array('frontend_settings'	=> array(	'name'		=> __('Front end', 'nm-wcpd'),
														'type'	=> 'tab',
														'desc'	=> __('Set options as per your need', 'nm-wcpd'),
														'meat'	=> $meatFrontend,
														
													),
		);