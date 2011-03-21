/**
 * VERSION: 0.9
 * DATE: 2010-08-09
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.GreenSock.com/LoaderMax/
 **/
package com.greensock.loading.data {
	import com.greensock.loading.core.LoaderCore;
	import com.greensock.loading.data.core.LoaderItemVars;
	
	import flash.display.DisplayObject;
/**
 * Can be used instead of a generic object to define the <code>vars</code> parameter of an XMLLoader's constructor. <br /><br />	
 * 
 * There are 2 primary benefits of using a XMLLoaderVars instance to define your XMLLoader variables:
 *  <ol>
 *		<li> In most code editors, code hinting will be activated which helps remind you which special properties are available in XMLLoader</li>
 *		<li> It enables strict data typing for improved debugging (ensuring, for example, that you don't define a Boolean value for <code>onComplete</code> where a Function is expected).</li>
 *  </ol>
 *
 * <strong>USAGE:</strong><br /><br />
 *	
 * Instead of <code>new XMLLoader("getData.php", {name:"myData", estimatedBytes:1500, onComplete:completeHandler, onProgress:progressHandler})</code>, 
 * you could use this utility like:<br /><br /><code>
 *	
 *		var vars:XMLLoaderVars = new XMLLoaderVars();<br />
 *		vars.name = "myData";<br />
 * 		vars.estimatedBytes = 1500;<br />
 * 		vars.onComplete = completeHandler;<br />
 * 		vars.onProgress = progressHandler;<br />
 *		var loader:XMLLoader = new XMLLoader("getData.php", vars);<br /><br /></code>
 *		
 * Some of the most common properties can be defined directly in the constructor like this:<br /><br /><code>
 *	
 *		var loader:XMLLoader = new XMLLoader("getData.php", new XMLLoaderVars("myData", 1500, completeHandler, progressHandler) );<br /><br /></code>
 *		
 * <strong>NOTE:</strong> Using XMLLoaderVars is completely optional. If you prefer the shorter synatax with the generic Object, feel
 * free to use it. The purpose of this class is simply to enable code hinting and to allow for strict data typing. <br /><br />
 * 
 * <b>Copyright 2010, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */	 
	dynamic public class XMLLoaderVars extends LoaderItemVars {
		/** @private **/
		private static var _vars:Array = ["integrateProgress",
										  "onChildOpen",
										  "onChildProgress",
										  "onChildComplete",
										  "onChildCancel",
										  "onChildFail"];
		
		/** By default, the XMLLoader will automatically look for LoaderMax-related nodes like <code>&lt;LoaderMax&gt;, &lt;ImageLoader&gt;, &lt;SWFLoader&gt;, &lt;XMLLoader&gt;, &lt;MP3Loader&gt;, &lt;DataLoader&gt;</code>, and <code>&lt;CSSLoader&gt;</code> inside the XML when it inits. If it finds any that have a <code>load="true"</code> attribute, it will begin loading them and integrate their progress into the XMLLoader's overall progress. Its <code>COMPLETE</code> event won't fire until all of these loaders have completed as well. If you prefer NOT to integrate the dynamically-created loader instances into the XMLLoader's overall <code>progress</code>, set <code>integrateProgress</code> to <code>false</code>. **/
		public var integrateProgress:Boolean=true;
		/** A handler function for <code>LoaderEvent.CHILD_OPEN</code> events which are dispatched each time any nested LoaderMax-related loaders that were defined in the XML begins loading. Make sure your onChildOpen function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). **/
		public var onChildOpen:Function;
		/** A handler function for <code>LoaderEvent.CHILD_PROGRESS</code> events which are dispatched each time any nested LoaderMax-related loaders that were defined in the XML dispatches a <code>PROGRESS</code> event. To listen for changes in the XMLLoader's overall progress, use the <code>onProgress</code> special property instead. You can use the LoaderEvent's <code>target.progress</code> to get the child loader's progress value or use its <code>target.bytesLoaded</code> and <code>target.bytesTotal</code>. The LoaderEvent's <code>currentTarget</code> refers to the XMLLoader, so you can check its overall progress with the LoaderEvent's <code>currentTarget.progress</code>. Make sure your onChildProgress function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). **/
		public var onChildProgress:Function;
		/** A handler function for <code>LoaderEvent.CHILD_COMPLETE</code> events which are dispatched each time any nested LoaderMax-related loaders that were defined in the XML finishes loading successfully. Make sure your onChildComplete function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). **/
		public var onChildComplete:Function;
		/** A handler function for <code>LoaderEvent.CHILD_CANCEL</code> events which are dispatched each time loading is aborted on any nested LoaderMax-related loaders that were defined in the XML due to either an error or because another loader was prioritized in the queue or because <code>cancel()</code> was manually called on the child loader. Make sure your onChildCancel function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). **/
		public var onChildCancel:Function;
		/** A handler function for <code>LoaderEvent.CHILD_FAIL</code> events which are dispatched each time any nested LoaderMax-related loaders that were defined in the XML fails (and its <code>status</code> chances to <code>LoaderStatus.FAILED</code>). Make sure your onChildFail function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). **/
 		public var onChildFail:Function;
		
		/**
		 * Constructor 
		 * 
		 * @param name A name that is used to identify the loader instance. This name can be fed to the <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> methods or traced at any time. Each loader's name should be unique. If you don't define one, a unique name will be created automatically, like "loader21".
		 * @param estimatedBytes Initially, the loader's <code>bytesTotal</code> is set to the <code>estimatedBytes</code> value (or <code>LoaderMax.defaultEstimatedBytes</code> if one isn't defined). Then, when the loader begins loading and it can accurately determine the bytesTotal, it will do so. Setting <code>estimatedBytes</code> is optional, but the more accurate the value, the more accurate your loaders' overall progress will be initially. If the loader is inserted into a LoaderMax instance (for queue management), its <code>auditSize</code> feature can attempt to automatically determine the <code>bytesTotal</code> at runtime (there is a slight performance penalty for this, however - see LoaderMax's documentation for details).
		 * @param onComplete A handler function for <code>LoaderEvent.COMPLETE</code> events which are dispatched when the loader has finished loading successfully. Make sure your onComplete function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).
		 * @param onProgress A handler function for <code>LoaderEvent.PROGRESS</code> events which are dispatched whenever the <code>bytesLoaded</code> changes. Make sure your onProgress function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). You can use the LoaderEvent's <code>target.progress</code> to get the loader's progress value or use its <code>target.bytesLoaded</code> and <code>target.bytesTotal</code>.
		 * @param onFail A handler function for <code>LoaderEvent.FAIL</code> events which are dispatched whenever the loader fails and its <code>status</code> changes to <code>LoaderStatus.FAILED</code>. Make sure your onFail function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). 
		 * @param noCache If <code>true</code>, a "cacheBusterID" parameter will be appended to the url with a random set of numbers to prevent caching (don't worry, this info is ignored when you <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> by <code>url</code> or when you're running locally).
		 * @param alternateURL If you define an <code>alternateURL</code>, the loader will initially try to load from its original <code>url</code> and if it fails, it will automatically (and permanently) change the loader's <code>url</code> to the <code>alternateURL</code> and try again. Think of it as a fallback or backup <code>url</code>. It is perfectly acceptable to use the same <code>alternateURL</code> for multiple loaders (maybe a default image for various ImageLoaders for example).
		 * @param requireWithRoot LoaderMax supports <i>subloading</i>, where an object can be factored into a parent's loading progress. If you want LoaderMax to require this loader as part of its parent SWFLoader's progress, you must set the <code>requireWithRoot</code> property to your swf's <code>root</code>. For example, <code>vars.requireWithRoot = this.root;</code>. 
		 */
		public function XMLLoaderVars(name:String="", 
									  estimatedBytes:uint=0,
									  onComplete:Function=null,
									  onProgress:Function=null,
									  onFail:Function=null,
									  noCache:Boolean=false,
									  alternateURL:String="",
									  requireWithRoot:DisplayObject=null) {
			super(name, estimatedBytes, onComplete, onProgress, onFail, noCache, alternateURL, requireWithRoot);
			_props = _props.concat(_vars);
		}
		
		/** Clones the object. **/
		public function clone():XMLLoaderVars {
			return _cloneProps(new XMLLoaderVars()) as XMLLoaderVars;
		}
		
	}
}