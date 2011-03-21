/**
 * VERSION: 0.9
 * DATE: 2010-08-09
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.GreenSock.com/LoaderMax/
 **/
package com.greensock.loading.data.core {
	import com.greensock.loading.data.core.LoaderCoreVars;
	
	import flash.display.DisplayObject;
/**
 * Facilitates code hinting and data type enforcement for the <code>vars</code> object that's passed into the 
 * constructor of various LoaderItems in the LoaderMax system. There is no reason to use this class directly - see
 * docs for the vars classes that extend LoaderItemVars like XMLLoaderVars, SWFLoaderVars, etc.<br /><br />
 * 
 * <b>Copyright 2010, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */	 
	dynamic public class LoaderItemVars extends LoaderCoreVars {
		/** @private **/
		private static var _vars:Array = ["estimatedBytes",
										  "noCache",
										  "alternateURL"];
		
		/** If you define an <code>alternateURL</code>, the loader will initially try to load from its original <code>url</code> and if it fails, it will automatically (and permanently) change the loader's <code>url</code> to the <code>alternateURL</code> and try again. Think of it as a fallback or backup <code>url</code>. It is perfectly acceptable to use the same <code>alternateURL</code> for multiple loaders (maybe a default image for various ImageLoaders for example). **/
		public var alternateURL:String;
		/** If <code>true</code>, a "cacheBusterID" parameter will be appended to the url with a random set of numbers to prevent caching (don't worry, this info is ignored when you <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> by <code>url</code> or when you're running locally). **/
		public var noCache:Boolean;
		/** Initially, the loader's <code>bytesTotal</code> is set to the <code>estimatedBytes</code> value (or <code>LoaderMax.defaultEstimatedBytes</code> if one isn't defined). Then, when the loader begins loading and it can accurately determine the bytesTotal, it will do so. Setting <code>estimatedBytes</code> is optional, but the more accurate the value, the more accurate your loaders' overall progress will be initially. If the loader is inserted into a LoaderMax instance (for queue management), its <code>auditSize</code> feature can attempt to automatically determine the <code>bytesTotal</code> at runtime (there is a slight performance penalty for this, however - see LoaderMax's documentation for details). **/
		public var estimatedBytes:uint;

		/**
		 * Constructor
		 * @private
		 */
		public function LoaderItemVars(name:String="", 
									   estimatedBytes:uint=0,
									   onComplete:Function=null,
									   onProgress:Function=null,
									   onFail:Function=null,
									   noCache:Boolean=false,
									   alternateURL:String="",
									   requireWithRoot:DisplayObject=null) {
			super(name, onComplete, onProgress, onFail, requireWithRoot);
			_props = _props.concat(_vars);
			this.estimatedBytes = estimatedBytes;
			this.noCache = noCache;
			this.alternateURL = alternateURL;
		}
		
	}
}