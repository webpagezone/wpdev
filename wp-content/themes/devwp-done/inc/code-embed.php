<?php
// This code is used to help deal with embeded code if you're using the Classic Editor Plugin and not the Gutenberg Editor.

// Escape HTML in <code> or <pre><code> tags.
	function devwp_escapeHTML( $arr ) {
		
		if ( version_compare( PHP_VERSION, '5.2.3' ) >= 0 ) {
			$output = htmlspecialchars( $arr[ 2 ], ENT_NOQUOTES, get_bloginfo( 'charset' ), false );
		} else {
			$specialChars = array(
				'&' => '&amp;',
				'<' => '&lt;',
				'>' => '&gt;'
			);
			
			// decode already converted data
			$data = htmlspecialchars_decode( $arr[ 2 ] );
			// escapse all data inside <pre>
			$output = strtr( $data, $specialChars );
		}
		if ( ! empty( $output ) ) {
			return $arr[ 1 ] . $output . $arr[ 3 ];
		} else {
			return $arr[ 1 ] . $arr[ 2 ] . $arr[ 3 ];
		}
	}
	
	function devwp_filterCode( $data ) { // Uncomment if you want to escape anything within a <pre> tag
		//$changedData = preg_replace_callback('@(<pre.*>)(.*)(<\/pre>)@isU', 'devwp_escapeHTML', $data);
		$changedData = preg_replace_callback( '@(<code.*>)(.*)(<\/code>)@isU', 'devwp_escapeHTML', $data );
		$changedData = preg_replace_callback( '@(<tt.*>)(.*)(<\/tt>)@isU', 'devwp_escapeHTML', $changedData );
		
		return $changedData;
	}
	
	add_filter( 'content_save_pre', 'devwp_filterCode', 9 );
	add_filter( 'excerpt_save_pre', 'devwp_filterCode', 9 );
