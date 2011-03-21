/**
 * VERSION: 0.9
 * DATE: 2010-08-09
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.GreenSock.com/LoaderMax/
 **/
package com.greensock.loading.data.core {
	import com.greensock.loading.data.core.LoaderItemVars;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.system.LoaderContext;

/**
 * Facilitates code hinting and data type enforcement for the <code>vars</code> object that's passed into the 
 * constructor of various DisplayObject-related loaders in the LoaderMax system. There is no reason to use this class directly - see
 * docs for the vars classes that extend DisplayObjectLoaderVars like ImageLoaderVars, SWFLoaderVars, VideoLoaderVars, etc.<br /><br />
 * 
 * <b>Copyright 2010, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */	
	dynamic public class DisplayObjectLoaderVars extends LoaderItemVars {
		/** @private **/
		private static var _vars:Array = ["container",
										  "width",
										  "height",
										  "centerRegistration",
										  "scaleMode",
										  "hAlign",
										  "vAlign",
										  "crop",
										  "x",
										  "y",
										  "scaleX",
										  "scaleY",
										  "rotation",
										  "alpha",
										  "visible",
										  "blendMode",
										  "bgColor",
										  "bgAlpha",
										  "onSecurityError"];
		
		/** A DisplayObjectContainer into which the <code>ContentDisplay</code> Sprite should be added immediately. **/
		public var container:DisplayObjectContainer;
		/** Sets the <code>ContentDisplay</code>'s <code>width</code> property (applied before rotation, scaleX, and scaleY). **/
		public var width:Number;
		/** Sets the <code>ContentDisplay</code>'s <code>height</code> property (applied before rotation, scaleX, and scaleY). **/
 		public var height:Number;
		/** If <code>true</code>, the registration point will be placed in the center of the ContentDisplay which can be useful if, for example, you want to animate its scale and have it grow/shrink from its center. **/
 		public var centerRegistration:Boolean;
		/** 
		 * When a <code>width</code> and <code>height</code> are defined, the <code>scaleMode</code> controls how the loaded image will be scaled to fit the area. The following values are recognized (you may use the <code>com.greensock.layout.ScaleMode</code> constants if you prefer):
 		 * <ul>
		 *	  <li><code>"stretch"</code> (the default) - The image will fill the width/height exactly. </li>
		 *	  <li><code>"proportionalInside"</code> - The image will be scaled proportionally to fit inside the area defined by the width/height</li>
		 *	  <li><code>"proportionalOutside"</code> - The image will be scaled proportionally to completely fill the area, allowing portions of it to exceed the bounds defined by the width/height. </li>
		 *	  <li><code>"widthOnly"</code> - Only the width of the image will be adjusted to fit.</li>
		 *	  <li><code>"heightOnly"</code> - Only the height of the image will be adjusted to fit.</li>
		 *	  <li><code>"none"</code> - No scaling of the image will occur. </li>
		 * </ul> 
		 **/
 		public var scaleMode:String;
		/** 
		 * When a <code>width</code> and <code>height</code> is defined, the <code>hAlign</code> determines how the image is horizontally aligned within that area. The following values are recognized (you may use the <code>com.greensock.layout.AlignMode</code> constants if you prefer):
		 * <ul>
		 * 		<li><code>"center"</code> (the default) - The image will be centered horizontally in the area</li>
		 * 		<li><code>"left"</code> - The image will be aligned with the left side of the area</li>
		 * 		<li><code>"right"</code> - The image will be aligned with the right side of the area</li>
		 * </ul>
		 **/
		public var hAlign:String="center";
		/** 
		 * When a <code>width</code> and <code>height</code> is defined, the <code>vAlign</code> determines how the image is vertically aligned within that area. The following values are recognized (you may use the <code>com.greensock.layout.AlignMode</code> constants if you prefer):
 		 * <ul>
		 * 		<li><code>"center"</code> (the default) - The image will be centered vertically in the area</li>
		 * 		<li><code>"top"</code> - The image will be aligned with the top of the area</li>
		 * 		<li><code>"bottom"</code> - The image will be aligned with the bottom of the area</li>
		 * </ul> 
		 **/
		public var vAlign:String="center";
		/** When a <code>width</code> and <code>height</code> are defined, setting <code>crop</code> to <code>true</code> will cause the image to be cropped within that area (by applying a <code>scrollRect</code> for maximum performance). This is typically useful when the <code>scaleMode</code> is <code>"proportionalOutside"</code> or <code>"none"</code> so that any parts of the image that exceed the dimensions defined by <code>width</code> and <code>height</code> are visually chopped off. Use the <code>hAlign</code> and <code>vAlign</code> special properties to control the vertical and horizontal alignment within the cropped area. **/
 		public var crop:Boolean;
		/** Sets the <code>ContentDisplay</code>'s <code>x</code> property (for positioning on the stage). **/
		public var x:Number = 0;
		/** Sets the <code>ContentDisplay</code>'s <code>y</code> property (for positioning on the stage). **/
 		public var y:Number = 0;
		/** Sets the <code>ContentDisplay</code>'s <code>scaleX</code> property. **/
 		public var scaleX:Number = 1;
		/** Sets the <code>ContentDisplay</code>'s <code>scaleY</code> property. **/
		public var scaleY:Number = 1;
		/** Sets the <code>ContentDisplay</code>'s <code>rotation</code> property. **/
 		public var rotation:Number = 0;
		/** Sets the <code>ContentDisplay</code>'s <code>alpha</code> property. **/
 		public var alpha:Number = 1;
		/** Sets the <code>ContentDisplay</code>'s <code>visible</code> property. **/
 		public var visible:Boolean = true;
		/** Sets the <code>ContentDisplay</code>'s <code>blendMode</code> property. **/
		public var blendMode:String="normal";
		/** When a <code>width</code> and <code>height</code> are defined, a rectangle will be drawn inside the <code>ContentDisplay</code> Sprite immediately in order to ease the development process. It is transparent by default, but you may define a <code>bgColor</code> if you prefer. **/
 		public var bgColor:uint=0;
		/** Controls the alpha of the rectangle that is drawn when a <code>width</code> and <code>height</code> are defined. **/
 		public var bgAlpha:Number=0;
		/** A handler function for <code>LoaderEvent.SECURITY_ERROR</code> events which onError handles as well, so you can use that as more of a catch-all whereas onSecurityError is specifically for SECURITY_ERROR events. Make sure your onSecurityError function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). **/
		public var onSecurityError:Function;
		
		/**
		 * Constructor 
		 * 
		 * @param name A name that is used to identify the loader instance. This name can be fed to the <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> methods or traced at any time. Each loader's name should be unique. If you don't define one, a unique name will be created automatically, like "loader21".
		 * @param estimatedBytes Initially, the loader's <code>bytesTotal</code> is set to the <code>estimatedBytes</code> value (or <code>LoaderMax.defaultEstimatedBytes</code> if one isn't defined). Then, when the loader begins loading and it can accurately determine the bytesTotal, it will do so. Setting <code>estimatedBytes</code> is optional, but the more accurate the value, the more accurate your loaders' overall progress will be initially. If the loader is inserted into a LoaderMax instance (for queue management), its <code>auditSize</code> feature can attempt to automatically determine the <code>bytesTotal</code> at runtime (there is a slight performance penalty for this, however - see LoaderMax's documentation for details).
		 * @param container A DisplayObjectContainer into which the <code>ContentDisplay</code> Sprite should be added immediately.
		 * @param width Sets the <code>ContentDisplay</code>'s <code>width</code> property (applied before rotation, scaleX, and scaleY).
		 * @param height Sets the <code>ContentDisplay</code>'s <code>height</code> property (applied before rotation, scaleX, and scaleY).
		 * @param scaleMode When a <code>width</code> and <code>height</code> are defined, the <code>scaleMode</code> controls how the loaded image will be scaled to fit the area. The following values are recognized (you may use the <code>com.greensock.layout.ScaleMode</code> constants if you prefer):<code>"stretch" | "proportionalInside" | "proportionalOutside" | "widthOnly" | "heightOnly" | "none"</code>
		 * @param onComplete A handler function for <code>LoaderEvent.COMPLETE</code> events which are dispatched when the loader has finished loading successfully. Make sure your onComplete function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).
		 * @param onProgress A handler function for <code>LoaderEvent.PROGRESS</code> events which are dispatched whenever the <code>bytesLoaded</code> changes. Make sure your onProgress function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). You can use the LoaderEvent's <code>target.progress</code> to get the loader's progress value or use its <code>target.bytesLoaded</code> and <code>target.bytesTotal</code>.
		 * @param onFail A handler function for <code>LoaderEvent.FAIL</code> events which are dispatched whenever the loader fails and its <code>status</code> changes to <code>LoaderStatus.FAILED</code>. Make sure your onFail function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). 
		 * @param noCache If <code>true</code>, a "cacheBusterID" parameter will be appended to the url with a random set of numbers to prevent caching (don't worry, this info is ignored when you <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> by <code>url</code> or when you're running locally).
		 * @param alternateURL If you define an <code>alternateURL</code>, the loader will initially try to load from its original <code>url</code> and if it fails, it will automatically (and permanently) change the loader's <code>url</code> to the <code>alternateURL</code> and try again. Think of it as a fallback or backup <code>url</code>. It is perfectly acceptable to use the same <code>alternateURL</code> for multiple loaders (maybe a default image for various ImageLoaders for example).
		 * @param requireWithRoot LoaderMax supports <i>subloading</i>, where an object can be factored into a parent's loading progress. If you want LoaderMax to require this loader as part of its parent SWFLoader's progress, you must set the <code>requireWithRoot</code> property to your swf's <code>root</code>. For example, <code>vars.requireWithRoot = this.root;</code>. 
		 */
		public function DisplayObjectLoaderVars(name:String="", 
									  estimatedBytes:uint=0,
									  container:DisplayObjectContainer=null,
									  width:Number=NaN,
									  height:Number=NaN,
									  scaleMode:String="stretch",
									  onComplete:Function=null,
									  onProgress:Function=null,
									  onFail:Function=null,
									  noCache:Boolean=false,
									  alternateURL:String="",
									  requireWithRoot:DisplayObject=null) {
			super(name, estimatedBytes, onComplete, onProgress, onFail, noCache, alternateURL, requireWithRoot);
			_props = _props.concat(_vars);
			this.container = container;
			this.width = width;
			this.height = height;
			this.scaleMode = scaleMode;
		}
		
	}
}