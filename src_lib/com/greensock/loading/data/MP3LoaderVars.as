/**
 * VERSION: 0.91
 * DATE: 2010-09-10
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.GreenSock.com/LoaderMax/
 **/
package com.greensock.loading.data {
	import com.greensock.loading.core.LoaderCore;
	import com.greensock.loading.data.core.LoaderItemVars;
	
	import flash.display.DisplayObject;
	import flash.media.SoundLoaderContext;

/**
 * Can be used instead of a generic object to define the <code>vars</code> parameter of an MP3Loader's constructor. <br /><br />	
 * 
 * There are 2 primary benefits of using a MP3LoaderVars instance to define your MP3Loader variables:
 *  <ol>
 *		<li> In most code editors, code hinting will be activated which helps remind you which special properties are available in MP3Loader</li>
 *		<li> It enables strict data typing for improved debugging (ensuring, for example, that you don't define a Boolean value for <code>onComplete</code> where a Function is expected).</li>
 *  </ol>
 *
 * <strong>USAGE:</strong><br /><br />
 *	
 * Instead of <code>new MP3Loader("audio.mp3", {name:"audio", estimatedBytes:11500, autoPlay:false, onComplete:completeHandler, onProgress:progressHandler})</code>, 
 * you could use this utility like:<br /><br /><code>
 *	
 *		var vars:MP3LoaderVars = new MP3LoaderVars();<br />
 *		vars.name = "audio";<br />
 * 		vars.estimatedBytes = 11500;<br />
 * 		vars.autoPlay = false;<br />
 * 		vars.onComplete = completeHandler;<br />
 * 		vars.onProgress = progressHandler;<br />
 *		var loader:MP3Loader = new MP3Loader("audio.mp3", vars);<br /><br /></code>
 *		
 * Some of the most common properties can be defined directly in the constructor like this:<br /><br /><code>
 *	
 *		var loader:MP3Loader = new MP3Loader("audio.mp3", new MP3LoaderVars("audio", 11500, false, completeHandler, progressHandler) );<br /><br /></code>
 *		
 * <strong>NOTE:</strong> Using MP3LoaderVars is completely optional. If you prefer the shorter synatax with the generic Object, feel
 * free to use it. The purpose of this class is simply to enable code hinting and to allow for strict data typing. <br /><br />
 * 
 * <b>Copyright 2010, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */	 
	dynamic public class MP3LoaderVars extends LoaderItemVars {
		/** @private **/
		private static var _vars:Array = ["autoPlay",
										  "repeat",
										  "volume",
										  "context",
										  "initThreshold"];
		
		/** By default the MP3 will begin playing immediately when enough of the file has buffered, but to prevent it from autoPlaying, set <code>autoPlay</code> to <code>false</code>. **/
		public var autoPlay:Boolean = true;
		/** Number of times that the mp3 should repeat. To repeat indefinitely, use -1. Default is 0. **/
 		public var repeat:int = 0;
		/** A value between 0 and 1 indicating the volume at which the sound should play when the MP3Loader's controls are used to play the sound, like <code>playSound()</code> or when <code>autoPlay</code> is <code>true</code> (default volume is 1). **/
 		public var volume:Number = 1;
		/** To control things like the buffer time and whether or not a policy file is checked, define a <code>SoundLoaderContext</code> object. The default context is null. See Adobe's SoundLoaderContext documentation for details. **/
 		public var context:SoundLoaderContext;
		/** The minimum number of <code>bytesLoaded</code> to wait for before the <code>LoaderEvent.INIT</code> event is dispatched - the higher the number the more accurate the <code>duration</code> estimate will be when the INIT event is dispatched (the default value is 102400 which is 100k). The MP3's duration cannot be determined with 100% accuracy until it has completely loaded, but it is estimated with more and more accuracy as the file loads. **/
		public var initThreshold:uint = 102400;
		
		/**
		 * Constructor 
		 * 
		 * @param name A name that is used to identify the loader instance. This name can be fed to the <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> methods or traced at any time. Each loader's name should be unique. If you don't define one, a unique name will be created automatically, like "loader21".
		 * @param estimatedBytes Initially, the loader's <code>bytesTotal</code> is set to the <code>estimatedBytes</code> value (or <code>LoaderMax.defaultEstimatedBytes</code> if one isn't defined). Then, when the loader begins loading and it can accurately determine the bytesTotal, it will do so. Setting <code>estimatedBytes</code> is optional, but the more accurate the value, the more accurate your loaders' overall progress will be initially. If the loader is inserted into a LoaderMax instance (for queue management), its <code>auditSize</code> feature can attempt to automatically determine the <code>bytesTotal</code> at runtime (there is a slight performance penalty for this, however - see LoaderMax's documentation for details).
		 * @param autoPlay By default, the MP3 will begin playing as soon as it has been adequately buffered, but to prevent it from playing initially, set <code>autoPlay</code> to <code>false</code>.
		 * @param onComplete A handler function for <code>LoaderEvent.COMPLETE</code> events which are dispatched when the loader has finished loading successfully. Make sure your onComplete function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).
		 * @param onProgress A handler function for <code>LoaderEvent.PROGRESS</code> events which are dispatched whenever the <code>bytesLoaded</code> changes. Make sure your onProgress function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). You can use the LoaderEvent's <code>target.progress</code> to get the loader's progress value or use its <code>target.bytesLoaded</code> and <code>target.bytesTotal</code>.
		 * @param onFail A handler function for <code>LoaderEvent.FAIL</code> events which are dispatched whenever the loader fails and its <code>status</code> changes to <code>LoaderStatus.FAILED</code>. Make sure your onFail function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). 
		 * @param noCache If <code>true</code>, a "cacheBusterID" parameter will be appended to the url with a random set of numbers to prevent caching (don't worry, this info is ignored when you <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> by <code>url</code> or when you're running locally).
		 * @param alternateURL If you define an <code>alternateURL</code>, the loader will initially try to load from its original <code>url</code> and if it fails, it will automatically (and permanently) change the loader's <code>url</code> to the <code>alternateURL</code> and try again. Think of it as a fallback or backup <code>url</code>. It is perfectly acceptable to use the same <code>alternateURL</code> for multiple loaders (maybe a default image for various ImageLoaders for example).
		 * @param requireWithRoot LoaderMax supports <i>subloading</i>, where an object can be factored into a parent's loading progress. If you want LoaderMax to require this loader as part of its parent SWFLoader's progress, you must set the <code>requireWithRoot</code> property to your swf's <code>root</code>. For example, <code>vars.requireWithRoot = this.root;</code>. 
		 */
		public function MP3LoaderVars(name:String="", 
									  estimatedBytes:uint=0,
									  autoPlay:Boolean=true,
									  onComplete:Function=null,
									  onProgress:Function=null,
									  onFail:Function=null,
									  noCache:Boolean=false,
									  alternateURL:String="",
									  requireWithRoot:DisplayObject=null) {
			super(name, estimatedBytes, onComplete, onProgress, onFail, noCache, alternateURL, requireWithRoot);
			_props = _props.concat(_vars);
			this.autoPlay = autoPlay;
		}
		
		/** Clones the object. **/
		public function clone():MP3LoaderVars {
			return _cloneProps(new MP3LoaderVars()) as MP3LoaderVars;
		}
		
	}
}