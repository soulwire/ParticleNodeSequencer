/**
 * VERSION: 1.0
 * DATE: 2010-10-02
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.greensock.com/loadermax/
 **/
package com.greensock.loading.data {
	import com.greensock.loading.data.core.DisplayObjectLoaderVars;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.system.LoaderContext;
/**
 * Can be used instead of a generic object to define the <code>vars</code> parameter of a VideoLoader's constructor. <br /><br />	
 * 
 * There are 2 primary benefits of using a VideoLoaderVars instance to define your VideoLoader variables:
 *  <ol>
 *		<li> In most code editors, code hinting will be activated which helps remind you which special properties are available in VideoLoader</li>
 *		<li> It enables strict data typing for improved debugging (ensuring, for example, that you don't define a Boolean value for <code>onComplete</code> where a Function is expected).</li>
 *  </ol>
 *
 * <strong>USAGE:</strong><br /><br />
 *	
 * Instead of <code>new VideoLoader("video.flv", {name:"video", estimatedBytes:111500, container:this, width:200, height:100, onComplete:completeHandler, onProgress:progressHandler})</code>, 
 * you could use this utility like:<br /><br /><code>
 *	
 *		var vars:VideoLoaderVars = new VideoLoaderVars();<br />
 *		vars.name = "video";<br />
 * 		vars.estimatedBytes = 111500;<br />
 * 		vars.container = this;<br />
 * 		vars.width = 200;<br />
 * 		vars.height = 100;<br />
 * 		vars.onComplete = completeHandler;<br />
 * 		vars.onProgress = progressHandler;<br />
 *		var loader:VideoLoader = new VideoLoader("video.flv", vars);<br /><br /></code>
 *		
 * Some of the most common properties can be defined directly in the constructor like this:<br /><br /><code>
 *	
 *		var loader:VideoLoader = new VideoLoader("video.flv", new VideoLoaderVars("video", 111500, this, 200, 100, completeHandler, progressHandler) );<br /><br /></code>
 *		
 * <strong>NOTE:</strong> Using VideoLoaderVars is completely optional. If you prefer the shorter synatax with the generic Object, feel
 * free to use it. The purpose of this class is simply to enable code hinting and to allow for strict data typing. <br /><br />
 * 
 * <b>Copyright 2010, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */	 
	dynamic public class VideoLoaderVars extends DisplayObjectLoaderVars {
		/** @private **/
		private static var _vars:Array = ["bufferTime",
										  "autoPlay",
										  "smoothing",
										  "repeat",
										  "checkPolicyFile",
										  "estimatedDuration",
										  "deblocking",
										  "bufferMode",
										  "volume",
										  "autoAdjustBuffer"];
		
		/** The amount of time (in seconds) that should be buffered before the video can begin playing (set <code>autoPlay</code> to <code>false</code> to pause the video initially).**/
		public var bufferTime:Number = 5;
		/** By default, the video will begin playing as soon as it has been adequately buffered, but to prevent it from playing initially, set <code>autoPlay</code> to <code>false</code>. **/
		public var autoPlay:Boolean = true;
		/** When <code>smoothing</code> is <code>true</code> (the default), smoothing will be enabled for the video which typically leads to better scaling results. **/
		public var smoothing:Boolean = true;
		/** Number of times that the video should repeat. To repeat indefinitely, use -1. Default is 0. **/
		public var repeat:int = 0;
		/** If <code>true</code>, the VideoLoader will check for a crossdomain.xml file on the remote host (only useful when loading videos from other domains - see Adobe's docs for details about NetStream's <code>checkPolicyFile</code> property). **/
		public var checkPolicyFile:Boolean;
		/** Estimated duration of the video in seconds. VideoLoader will only use this value until it receives the necessary metaData from the video in order to accurately determine the video's duration. You do not need to specify an <code>estimatedDuration</code>, but doing so can help make the playProgress and some other values more accurate (until the metaData has loaded). It can also make the <code>progress/bytesLoaded/bytesTotal</code> more accurate when a <code>estimatedDuration</code> is defined, particularly in <code>bufferMode</code>.**/
		public var estimatedDuration:Number;
		/** Indicates the type of filter applied to decoded video as part of post-processing. The default value is 0, which lets the video compressor apply a deblocking filter as needed. See Adobe's <code>flash.media.Video</code> class docs for details. **/
		public var deblocking:int = 0;
		/** When <code>true</code>, the loader will report its progress only in terms of the video's buffer which can be very convenient if, for example, you want to display loading progress for the video's buffer or tuck it into a LoaderMax with other loaders and allow the LoaderMax to dispatch its <code>COMPLETE</code> event when the buffer is full instead of waiting for the whole file to download. When <code>bufferMode</code> is <code>true</code>, the VideoLoader will dispatch its <code>COMPLETE</code> event when the buffer is full as opposed to waiting for the entire video to load. You can toggle the <code>bufferMode</code> anytime. Please read the full <code>bufferMode</code> property ASDoc description below for details about how it affects things like <code>bytesTotal</code>.**/
		public var bufferMode:Boolean;
		/** A value between 0 and 1 indicating the volume at which the video should play (default is 1).**/
		public var volume:Number = 1;
		/** If the buffer becomes empty during playback and <code>autoAdjustBuffer</code> is <code>true</code> (the default), it will automatically attempt to adjust the NetStream's <code>bufferTime</code> based on the rate at which the video has been loading, estimating what it needs to be in order to play the rest of the video without emptying the buffer again. This can prevent the annoying problem of video playback start/stopping/starting/stopping on a system tht doesn't have enough bandwidth to adequately buffer the video. You may also set the <code>bufferTime</code> in the constructor's <code>vars</code> parameter to set the initial value. **/
		public var autoAdjustBuffer:Boolean = true;
		
		/**
		 * Constructor 
		 * 
		 * @param name A name that is used to identify the loader instance. This name can be fed to the <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> methods or traced at any time. Each loader's name should be unique. If you don't define one, a unique name will be created automatically, like "loader21".
		 * @param estimatedBytes Initially, the loader's <code>bytesTotal</code> is set to the <code>estimatedBytes</code> value (or <code>LoaderMax.defaultEstimatedBytes</code> if one isn't defined). Then, when the loader begins loading and it can accurately determine the bytesTotal, it will do so. Setting <code>estimatedBytes</code> is optional, but the more accurate the value, the more accurate your loaders' overall progress will be initially. If the loader is inserted into a LoaderMax instance (for queue management), its <code>auditSize</code> feature can attempt to automatically determine the <code>bytesTotal</code> at runtime (there is a slight performance penalty for this, however - see LoaderMax's documentation for details).
		 * @param container A DisplayObjectContainer into which the <code>ContentDisplay</code> Sprite should be added immediately.
		 * @param autoPlay By default, the video will begin playing as soon as it has been adequately buffered, but to prevent it from playing initially, set <code>autoPlay</code> to <code>false</code>.
		 * @param width Sets the <code>ContentDisplay</code>'s <code>width</code> property (applied before rotation, scaleX, and scaleY).
		 * @param height Sets the <code>ContentDisplay</code>'s <code>height</code> property (applied before rotation, scaleX, and scaleY).
		 * @param scaleMode When a <code>width</code> and <code>height</code> are defined, the <code>scaleMode</code> controls how the loaded image will be scaled to fit the area. The following values are recognized (you may use the <code>com.greensock.layout.ScaleMode</code> constants if you prefer):<code>"stretch" | "proportionalInside" | "proportionalOutside" | "widthOnly" | "heightOnly" | "none"</code>
		 * @param onComplete A handler function for <code>LoaderEvent.COMPLETE</code> events which are dispatched when the loader has finished loading successfully. Make sure your onComplete function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).
		 * @param onProgress A handler function for <code>LoaderEvent.PROGRESS</code> events which are dispatched whenever the <code>bytesLoaded</code> changes. Make sure your onProgress function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). You can use the LoaderEvent's <code>target.progress</code> to get the loader's progress value or use its <code>target.bytesLoaded</code> and <code>target.bytesTotal</code>.
		 * @param onFail A handler function for <code>LoaderEvent.FAIL</code> events which are dispatched whenever the loader fails and its <code>status</code> changes to <code>LoaderStatus.FAILED</code>. Make sure your onFail function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). 
		 * @param noCache If <code>true</code>, a "cacheBusterID" parameter will be appended to the url with a random set of numbers to prevent caching (don't worry, this info is ignored when you <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> by <code>url</code> or when you're running locally).
		 * @param alternateURL If you define an <code>alternateURL</code>, the loader will initially try to load from its original <code>url</code> and if it fails, it will automatically (and permanently) change the loader's <code>url</code> to the <code>alternateURL</code> and try again. Think of it as a fallback or backup <code>url</code>. It is perfectly acceptable to use the same <code>alternateURL</code> for multiple loaders (maybe a default image for various VideoLoaders for example).
		 * @param requireWithRoot LoaderMax supports <i>subloading</i>, where an object can be factored into a parent's loading progress. If you want LoaderMax to require this loader as part of its parent SWFLoader's progress, you must set the <code>requireWithRoot</code> property to your swf's <code>root</code>. For example, <code>vars.requireWithRoot = this.root;</code>. 
		 */
		public function VideoLoaderVars(name:String="", 
									  estimatedBytes:uint=0,
									  container:DisplayObjectContainer=null,
									  autoPlay:Boolean=true,
									  width:Number=NaN,
									  height:Number=NaN,
									  scaleMode:String="stretch",
									  onComplete:Function=null,
									  onProgress:Function=null,
									  onFail:Function=null,
									  noCache:Boolean=false,
									  alternateURL:String="",
									  requireWithRoot:DisplayObject=null) {
			super(name, estimatedBytes, container, width, height, scaleMode, onComplete, onProgress, onFail, noCache, alternateURL, requireWithRoot);
			_props = _props.concat(_vars);
			this.autoPlay = autoPlay;
		}
		
		/** Clones the object. **/
		public function clone():VideoLoaderVars {
			return _cloneProps(new VideoLoaderVars()) as VideoLoaderVars;
		}
		
	}
}