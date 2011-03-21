/**
 * VERSION: 0.9
 * DATE: 2010-08-09
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.GreenSock.com/LoaderMax/
 **/
package com.greensock.loading.data {
	import com.greensock.loading.core.LoaderCore;
	import com.greensock.loading.data.core.LoaderCoreVars;
	import com.greensock.loading.LoaderMax;
	
	import flash.display.DisplayObject;
/**
 * Can be used instead of a generic object to define the <code>vars</code> parameter of a LoaderMax's constructor. <br /><br />	
 * 
 * There are 2 primary benefits of using a LoaderMaxVars instance to define your LoaderMax variables:
 *  <ol>
 *		<li> In most code editors, code hinting will be activated which helps remind you which special properties are available in LoaderMax</li>
 *		<li> It enables strict data typing for improved debugging (ensuring, for example, that you don't define a Boolean value for <code>onComplete</code> where a Function is expected).</li>
 *  </ol>
 *
 * <strong>USAGE:</strong><br /><br />
 *	
 *	Instead of <code>new LoaderMax({name:"mainQueue", onComplete:completeHandler, onProgress:progressHandler})</code>, you could use this utility like:<br /><br /><code>
 *	
 *		var vars:LoaderMaxVars = new LoaderMaxVars();<br />
 *		vars.name = "mainQueue";<br />
 * 		vars.onComplete = completeHandler;<br />
 * 		vars.onProgress = progressHandler;<br />
 *		var queue:LoaderMax = new LoaderMax(vars);<br /><br /></code>
 *		
 * Some of the most common properties can be defined directly in the constructor like this:<br /><br /><code>
 *	
 *		var queue:LoaderMax = new LoaderMax( new LoaderMaxVars("mainQueue", completeHandler, progressHandler) );<br /><br /></code>
 *		
 * <strong>NOTE:</strong> Using LoaderMaxVars is completely optional. If you prefer the shorter synatax with the generic Object, feel
 * free to use it. The purpose of this class is simply to enable code hinting and to allow for strict data typing. <br /><br />
 * 
 * <b>Copyright 2010, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */	 
	dynamic public class LoaderMaxVars extends LoaderCoreVars {
		/** @private **/
		private static var _vars:Array = ["auditSize",
										  "maxConnections",
										  "skipFailed",
										  "skipPaused",
										  "loaders",
										  "onChildOpen",
										  "onChildProgress",
										  "onChildComplete",
										  "onChildCancel",
										  "onChildFail",
										  "onScriptAccessDenied"];
		
		/** By default, when the LoaderMax begins to load it quickly loops through its children and if it finds any that don't have an <code>estimatedBytes</code> defined, it will briefly open a URLStream in order to attempt to determine its <code>bytesTotal</code>, immediately closing the URLStream once the value has been determined. This causes a brief delay initially, but greatly improves the accuracy of the <code>progress</code> and <code>bytesTotal</code> values. Set <code>auditSize</code> to <code>false</code> to prevent the LoaderMax from auditing its childrens' size (it is <code>true</code> by default). For maximum performance, it is best to define an <code>estimatedBytes</code> value for as many loaders as possible to avoid the delay caused by audits. When the LoaderMax audits an XMLLoader, it cannot recognize loaders that will be created from the XML data nor can it recognize loaders inside subloaded swf files from a SWFLoader (it would take far too long to load sufficient data for that - audits should be as fast as possible). If you do not set an appropriate <code>estimatedSize</code> for XMLLoaders or SWFLoaders that contain LoaderMax loaders, you'll notice that the parent LoaderMax's <code>progress</code> and <code>bytesTotal</code> change when the nested loaders are recognized (this is normal). To control the default <code>auditSize</code> value, use the static <code>LoaderMax.defaultAuditSize</code> property. **/
		public var auditSize:Boolean;
		/** Maximum number of simultaneous connections that should be used while loading the LoaderMax queue. A higher number will generally result in faster overall load times for the group. The default is 2. This value is instance-based, not system-wide, so if you have two LoaderMax instances that both have a <code>maxConnections</code> value of 3 and they are both loading, there could be up to 6 connections at a time total. Sometimes there are limits imposed by the Flash Player itself or the browser or the user's system, but LoaderMax will do its best to honor the <code>maxConnections</code> you define. **/
		public var maxConnections:uint;
		/** If <code>skipFailed</code> is <code>true</code> (the default), any failed loaders in the queue will be skipped. Otherwise, the LoaderMax will stop when it hits a failed loader and the LoaderMax's status will become <code>LoaderStatus.FAILED</code>. **/
		public var skipFailed:Boolean;
		/** If <code>skipPaused</code> is <code>true</code> (the default), any paused loaders in the queue will be skipped. Otherwise, the LoaderMax will stop when it hits a paused loader and the LoaderMax's status will become <code>LoaderStatus.FAILED</code>. **/
		public var skipPaused:Boolean;
		/** An array of loaders (ImageLoaders, SWFLoaders, XMLLoaders, MP3Loaders, other LoaderMax instances, etc.) that should be immediately inserted into the LoaderMax. **/
		public var loaders:Array;

		/** A handler function for <code>LoaderEvent.CHILD_OPEN</code> events which are dispatched each time one of the loader's children (or any descendant) begins loading. Make sure your onChildOpen function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). **/
		public var onChildOpen:Function;
		/** A handler function for <code>LoaderEvent.CHILD_PROGRESS</code> events which are dispatched each time one of the loader's children (or any descendant) dispatches a <code>PROGRESS</code> event. To listen for changes in the LoaderMax's overall progress, use the <code>onProgress</code> special property instead. You can use the LoaderEvent's <code>target.progress</code> to get the child loader's progress value or use its <code>target.bytesLoaded</code> and <code>target.bytesTotal</code>. The LoaderEvent's <code>currentTarget</code> refers to the LoaderMax, so you can check its overall progress with the LoaderEvent's <code>currentTarget.progress</code>. Make sure your onChildProgress function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). **/
		public var onChildProgress:Function;
		/** A handler function for <code>LoaderEvent.CHILD_COMPLETE</code> events which are dispatched each time one of the loader's children (or any descendant) finishes loading successfully. Make sure your onChildComplete function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). **/
		public var onChildComplete:Function;
		/** A handler function for <code>LoaderEvent.CHILD_CANCEL</code> events which are dispatched each time loading is aborted on one of the loader's children (or any descendant) due to either an error or because another loader was prioritized in the queue or because <code>cancel()</code> was manually called on the child loader. Make sure your onChildCancel function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). **/
		public var onChildCancel:Function;
		/** A handler function for <code>LoaderEvent.CHILD_FAIL</code> events which are dispatched each time one of the loader's children (or any descendant) fails (and its <code>status</code> chances to <code>LoaderStatus.FAILED</code>). Make sure your onChildFail function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). **/
		public var onChildFail:Function;
		/** A handler function for <code>LoaderEvent.SCRIPT_ACCESS_DENIED</code> events which are dispatched when one of the LoaderMax's children (or any descendant) is loaded from another domain and no crossdomain.xml is in place to grant full script access for things like smoothing or BitmapData manipulation. Make sure your function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).**/
		public var onScriptAccessDenied:Function;

		
		/**
		 * Constructor
		 * 
		 */
		public function LoaderMaxVars(name:String="", 
									   onComplete:Function=null,
									   onProgress:Function=null,
									   onFail:Function=null,
									   maxConnections:uint=2,
									   auditSize:Boolean=true,
									   requireWithRoot:DisplayObject=null,
									   skipFailed:Boolean=true,
									   skipPaused:Boolean=true) {
			super(name, onComplete, onProgress, onFail, requireWithRoot);
			_props = _props.concat(_vars);
			this.maxConnections = maxConnections;
			this.auditSize = (arguments.length >= 6) ? auditSize : LoaderMax.defaultAuditSize;
			this.skipFailed = skipFailed;
			this.skipPaused = skipPaused;
		}
		
		/** Clones the object. **/
		public function clone():LoaderMaxVars {
			return _cloneProps(new LoaderMaxVars()) as LoaderMaxVars;
		}
		
	}
}