package mx.resources
{
   import flash.events.EventDispatcher;
   import mx.core.mx_internal;
   import flash.utils.Dictionary;
   import flash.system.ApplicationDomain;
   import flash.events.FocusEvent;
   import mx.managers.SystemManagerGlobals;
   import flash.events.IEventDispatcher;
   import flash.system.SecurityDomain;
   import mx.modules.IModuleInfo;
   import flash.utils.Timer;
   import mx.modules.ModuleManager;
   import mx.events.ModuleEvent;
   import mx.events.ResourceEvent;
   import flash.events.TimerEvent;
   import flash.events.Event;
   import mx.utils.StringUtil;
   import flash.system.Capabilities;
   import mx.events.FlexEvent;

   use namespace mx_internal;

   public class ResourceManagerImpl extends EventDispatcher implements IResourceManager
   {
      public function ResourceManagerImpl() {
         this.localeMap={};
         this.resourceModules={};
         super();
         var _loc1_:Object = SystemManagerGlobals.info;
         if(_loc1_)
         {
            this.processInfo(_loc1_,false);
         }
         if(SystemManagerGlobals.topLevelSystemManagers.length)
         {
            SystemManagerGlobals.topLevelSystemManagers[0].addEventListener(FlexEvent.NEW_CHILD_APPLICATION,this.newChildApplicationHandler);
         }
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private static var instance:IResourceManager;

      public static function getInstance() : IResourceManager {
         if(!instance)
         {
            instance=new ResourceManagerImpl();
         }
         return instance;
      }

      private var bundleDictionary:Dictionary;

      private var localeMap:Object;

      private var resourceModules:Object;

      private var initializedForNonFrameworkApp:Boolean = false;

      private var _localeChain:Array;

      public function get localeChain() : Array {
         return this._localeChain;
      }

      public function set localeChain(param1:Array) : void {
         this._localeChain=param1;
         this.update();
         return;
      }

      public function installCompiledResourceBundles(param1:ApplicationDomain, param2:Array, param3:Array, param4:Boolean=false) : Array {
         var _loc10_:String = null;
         var _loc11_:* = 0;
         var _loc12_:String = null;
         var _loc5_:Array = [];
         var _loc6_:uint = 0;
         var _loc7_:int = param2?param2.length:0;
         var _loc8_:int = param3?param3.length:0;
         var _loc9_:* = 0;
         return _loc5_;
      }

      private function installCompiledResourceBundle(param1:ApplicationDomain, param2:String, param3:String, param4:Boolean=false) : IResourceBundle {
         var _loc5_:String = null;
         var _loc6_:String = param3;
         var _loc7_:int = param3.indexOf(":");
         if(_loc7_ != -1)
         {
            _loc5_=param3.substring(0,_loc7_);
            _loc6_=param3.substring(_loc7_ + 1);
         }
         var _loc8_:IResourceBundle = this.getResourceBundleInternal(param2,param3,param4);
         if(_loc8_)
         {
            return _loc8_;
         }
         var _loc9_:* = param2 + "$" + _loc6_ + "_properties";
         var _loc10_:Class = null;
         if(param1.hasDefinition(_loc9_))
         {
            _loc10_=Class(param1.getDefinition(_loc9_));
         }
         _loc9_=param3;
         if(param1.hasDefinition(_loc9_))
         {
            _loc10_=Class(param1.getDefinition(_loc9_));
         }
         _loc9_=param3 + "_properties";
         if(param1.hasDefinition(_loc9_))
         {
            _loc10_=Class(param1.getDefinition(_loc9_));
         }
         throw new Error("Could not find compiled resource bundle \'" + param3 + "\' for locale \'" + param2 + "\'.");
      }

      private function newChildApplicationHandler(param1:FocusEvent) : void {
         var _loc2_:Object = param1.relatedObject["info"]();
         var _loc3_:* = false;
         if("_resourceBundles"  in  param1.relatedObject)
         {
            _loc3_=true;
         }
         var _loc4_:Array = this.processInfo(_loc2_,_loc3_);
         return;
      }

      private function processInfo(param1:Object, param2:Boolean) : Array {
         var _loc3_:Array = param1["compiledLocales"];
         ResourceBundle.locale=!(_loc3_ == null) && _loc3_.length > 0?_loc3_[0]:"en_US";
         var _loc4_:String = SystemManagerGlobals.parameters["localeChain"];
         if(!(_loc4_ == null) && !(_loc4_ == ""))
         {
            this.localeChain=_loc4_.split(",");
         }
         var _loc5_:ApplicationDomain = param1["currentDomain"];
         var _loc6_:Array = param1["compiledResourceBundleNames"];
         var _loc7_:Array = this.installCompiledResourceBundles(_loc5_,_loc3_,_loc6_,param2);
         if(!this.localeChain)
         {
            this.initializeLocaleChain(_loc3_);
         }
         return _loc7_;
      }

      public function initializeLocaleChain(param1:Array) : void {
         this.localeChain=LocaleSorter.sortLocalesByPreference(param1,this.getSystemPreferredLocales(),null,true);
         return;
      }

      public function loadResourceModule(param1:String, param2:Boolean=true, param3:ApplicationDomain=null, param4:SecurityDomain=null) : IEventDispatcher {
         var moduleInfo:IModuleInfo = null;
         var resourceEventDispatcher:ResourceEventDispatcher = null;
         var timer:Timer = null;
         var timerHandler:Function = null;
         var url:String = param1;
         var updateFlag:Boolean = param2;
         var applicationDomain:ApplicationDomain = param3;
         var securityDomain:SecurityDomain = param4;
         moduleInfo=ModuleManager.getModule(url);
         resourceEventDispatcher=new ResourceEventDispatcher(moduleInfo);
         var readyHandler:Function = new function(param1:ModuleEvent):void
         {
            var _loc2_:* = param1.module.factory.create();
            resourceModules[param1.module.url].resourceModule=_loc2_;
            if(updateFlag)
            {
                  update();
            }
            return;
         };
         moduleInfo.addEventListener(ModuleEvent.READY,readyHandler,false,0,true);
         var errorHandler:Function = new function(param1:ModuleEvent):void
         {
            var _loc3_:ResourceEvent = null;
            var _loc2_:String = "Unable to load resource module from " + url;
            if(resourceEventDispatcher.willTrigger(ResourceEvent.ERROR))
            {
                  _loc3_=new ResourceEvent(ResourceEvent.ERROR,param1.bubbles,param1.cancelable);
                  _loc3_.bytesLoaded=0;
                  _loc3_.bytesTotal=0;
                  _loc3_.errorText=_loc2_;
                  resourceEventDispatcher.dispatchEvent(_loc3_);
                  return;
            }
            throw new Error(_loc2_);
         };
         moduleInfo.addEventListener(ModuleEvent.ERROR,errorHandler,false,0,true);
         this.resourceModules[url]=new ResourceModuleInfo(moduleInfo,readyHandler,errorHandler);
         timer=new Timer(0);
         timerHandler=new function(param1:TimerEvent):void
         {
            timer.removeEventListener(TimerEvent.TIMER,timerHandler);
            timer.stop();
            moduleInfo.load(applicationDomain,securityDomain);
            return;
         };
         timer.addEventListener(TimerEvent.TIMER,timerHandler,false,0,true);
         timer.start();
         return resourceEventDispatcher;
      }

      public function unloadResourceModule(param1:String, param2:Boolean=true) : void {
         var _loc4_:Array = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc3_:ResourceModuleInfo = this.resourceModules[param1];
         if(!_loc3_)
         {
            return;
         }
         if(_loc3_.resourceModule)
         {
            _loc4_=_loc3_.resourceModule.resourceBundles;
            if(_loc4_)
            {
               _loc5_=_loc4_.length;
               _loc6_=0;
               while(_loc6_ < _loc5_)
               {
                  _loc7_=_loc4_[_loc6_].locale;
                  _loc8_=_loc4_[_loc6_].bundleName;
                  this.removeResourceBundle(_loc7_,_loc8_);
                  _loc6_++;
               }
            }
         }
         this.resourceModules[param1]=null;
         delete this.resourceModules[[param1]];
         _loc3_.moduleInfo.unload();
         if(param2)
         {
            this.update();
         }
         return;
      }

      public function addResourceBundle(param1:IResourceBundle, param2:Boolean=false) : void {
         var _loc3_:String = param1.locale;
         var _loc4_:String = param1.bundleName;
         if(!this.localeMap[_loc3_])
         {
            this.localeMap[_loc3_]={};
         }
         if(param2)
         {
            if(!this.bundleDictionary)
            {
               this.bundleDictionary=new Dictionary(true);
            }
            this.bundleDictionary[param1]=_loc3_ + _loc4_;
            this.localeMap[_loc3_][_loc4_]=this.bundleDictionary;
         }
         else
         {
            this.localeMap[_loc3_][_loc4_]=param1;
         }
         return;
      }

      public function getResourceBundle(param1:String, param2:String) : IResourceBundle {
         return this.getResourceBundleInternal(param1,param2,false);
      }

      private function getResourceBundleInternal(param1:String, param2:String, param3:Boolean) : IResourceBundle {
         var _loc7_:String = null;
         var _loc8_:Object = null;
         var _loc4_:Object = this.localeMap[param1];
         if(!_loc4_)
         {
            return null;
         }
         var _loc5_:IResourceBundle = null;
         var _loc6_:Object = _loc4_[param2];
         if(_loc6_  is  Dictionary)
         {
            if(param3)
            {
               return null;
            }
            _loc7_=param1 + param2;
            for (_loc8_ in _loc6_)
            {
               if(_loc6_[_loc8_] == _loc7_)
               {
                  _loc5_=_loc8_ as IResourceBundle;
                  break;
               }
            }
         }
         else
         {
            _loc5_=_loc6_ as IResourceBundle;
         }
         return _loc5_;
      }

      public function removeResourceBundle(param1:String, param2:String) : void {
         delete this.localeMap[param1][[param2]];
         if(this.getBundleNamesForLocale(param1).length == 0)
         {
            delete this.localeMap[[param1]];
         }
         return;
      }

      public function removeResourceBundlesForLocale(param1:String) : void {
         delete this.localeMap[[param1]];
         return;
      }

      public function update() : void {
         dispatchEvent(new Event(Event.CHANGE));
         return;
      }

      public function getLocales() : Array {
         var _loc2_:String = null;
         var _loc1_:Array = [];
         for (_loc2_ in this.localeMap)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }

      public function getPreferredLocaleChain() : Array {
         return LocaleSorter.sortLocalesByPreference(this.getLocales(),this.getSystemPreferredLocales(),null,true);
      }

      public function getBundleNamesForLocale(param1:String) : Array {
         var _loc3_:String = null;
         var _loc2_:Array = [];
         for (_loc3_ in this.localeMap[param1])
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }

      public function findResourceBundleWithResource(param1:String, param2:String) : IResourceBundle {
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:IResourceBundle = null;
         var _loc9_:String = null;
         var _loc10_:Object = null;
         if(!this._localeChain)
         {
            return null;
         }
         var _loc3_:int = this._localeChain.length;
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_=this.localeChain[_loc4_];
            _loc6_=this.localeMap[_loc5_];
            if(_loc6_)
            {
               _loc7_=_loc6_[param1];
               if(_loc7_)
               {
                  _loc8_=null;
                  if(_loc7_  is  Dictionary)
                  {
                     _loc9_=_loc5_ + param1;
                     for (_loc10_ in _loc7_)
                     {
                        if(_loc7_[_loc10_] == _loc9_)
                        {
                           _loc8_=_loc10_ as IResourceBundle;
                           break;
                        }
                     }
                  }
                  else
                  {
                     _loc8_=_loc7_ as IResourceBundle;
                  }
                  if((_loc8_) && param2  in  _loc8_.content)
                  {
                     return _loc8_;
                  }
               }
            }
            _loc4_++;
         }
         return null;
      }

      public function getObject(param1:String, param2:String, param3:String=null) : * {
         var _loc4_:IResourceBundle = this.findBundle(param1,param2,param3);
         if(!_loc4_)
         {
            return undefined;
         }
         return _loc4_.content[param2];
      }

      public function getString(param1:String, param2:String, param3:Array=null, param4:String=null) : String {
         var _loc5_:IResourceBundle = this.findBundle(param1,param2,param4);
         if(!_loc5_)
         {
            return null;
         }
         var _loc6_:String = String(_loc5_.content[param2]);
         if(param3)
         {
            _loc6_=StringUtil.substitute(_loc6_,param3);
         }
         return _loc6_;
      }

      public function getStringArray(param1:String, param2:String, param3:String=null) : Array {
         var _loc4_:IResourceBundle = this.findBundle(param1,param2,param3);
         if(!_loc4_)
         {
            return null;
         }
         var _loc5_:* = _loc4_.content[param2];
         var _loc6_:Array = String(_loc5_).split(",");
         var _loc7_:int = _loc6_.length;
         var _loc8_:* = 0;
         while(_loc8_ < _loc7_)
         {
            _loc6_[_loc8_]=StringUtil.trim(_loc6_[_loc8_]);
            _loc8_++;
         }
         return _loc6_;
      }

      public function getNumber(param1:String, param2:String, param3:String=null) : Number {
         var _loc4_:IResourceBundle = this.findBundle(param1,param2,param3);
         if(!_loc4_)
         {
            return NaN;
         }
         var _loc5_:* = _loc4_.content[param2];
         return Number(_loc5_);
      }

      public function getInt(param1:String, param2:String, param3:String=null) : int {
         var _loc4_:IResourceBundle = this.findBundle(param1,param2,param3);
         if(!_loc4_)
         {
            return 0;
         }
         var _loc5_:* = _loc4_.content[param2];
         return int(_loc5_);
      }

      public function getUint(param1:String, param2:String, param3:String=null) : uint {
         var _loc4_:IResourceBundle = this.findBundle(param1,param2,param3);
         if(!_loc4_)
         {
            return 0;
         }
         var _loc5_:* = _loc4_.content[param2];
         return uint(_loc5_);
      }

      public function getBoolean(param1:String, param2:String, param3:String=null) : Boolean {
         var _loc4_:IResourceBundle = this.findBundle(param1,param2,param3);
         if(!_loc4_)
         {
            return false;
         }
         var _loc5_:* = _loc4_.content[param2];
         return String(_loc5_).toLowerCase() == "true";
      }

      public function getClass(param1:String, param2:String, param3:String=null) : Class {
         var _loc4_:IResourceBundle = this.findBundle(param1,param2,param3);
         if(!_loc4_)
         {
            return null;
         }
         var _loc5_:* = _loc4_.content[param2];
         return _loc5_ as Class;
      }

      private function findBundle(param1:String, param2:String, param3:String) : IResourceBundle {
         this.supportNonFrameworkApps();
         return param3 != null?this.getResourceBundle(param3,param1):this.findResourceBundleWithResource(param1,param2);
      }

      private function supportNonFrameworkApps() : void {
         if(this.initializedForNonFrameworkApp)
         {
            return;
         }
         this.initializedForNonFrameworkApp=true;
         if(this.getLocales().length > 0)
         {
            return;
         }
         var _loc1_:ApplicationDomain = ApplicationDomain.currentDomain;
         if(!_loc1_.hasDefinition("_CompiledResourceBundleInfo"))
         {
            return;
         }
         var _loc2_:Class = Class(_loc1_.getDefinition("_CompiledResourceBundleInfo"));
         var _loc3_:Array = _loc2_.compiledLocales;
         var _loc4_:Array = _loc2_.compiledResourceBundleNames;
         this.installCompiledResourceBundles(_loc1_,_loc3_,_loc4_);
         this.localeChain=_loc3_;
         return;
      }

      private function getSystemPreferredLocales() : Array {
         var _loc1_:Array = null;
         if(Capabilities["languages"])
         {
            _loc1_=Capabilities["languages"];
         }
         else
         {
            _loc1_=[Capabilities.language];
         }
         return _loc1_;
      }

      private function dumpResourceModule(param1:*) : void {
         var _loc2_:ResourceBundle = null;
         var _loc3_:String = null;
         for each (_loc2_ in param1.resourceBundles)
         {
            trace(_loc2_.locale,_loc2_.bundleName);
            for (_loc3_ in _loc2_.content)
            {
            }
         }
         return;
      }
   }

}   import mx.modules.IModuleInfo;
   import mx.resources.IResourceModule;


   class ResourceModuleInfo extends Object
   {
      function ResourceModuleInfo(param1:IModuleInfo, param2:Function, param3:Function) {
         super();
         this.moduleInfo=param1;
         this.readyHandler=param2;
         this.errorHandler=param3;
         return;
      }

      public var errorHandler:Function;

      public var moduleInfo:IModuleInfo;

      public var readyHandler:Function;

      public var resourceModule:IResourceModule;
   }
   import flash.events.EventDispatcher;
   import mx.events.ModuleEvent;
   import mx.events.ResourceEvent;
   import mx.modules.IModuleInfo;


   class ResourceEventDispatcher extends EventDispatcher
   {
      function ResourceEventDispatcher(param1:IModuleInfo) {
         super();
         param1.addEventListener(ModuleEvent.ERROR,this.moduleInfo_errorHandler,false,0,true);
         param1.addEventListener(ModuleEvent.PROGRESS,this.moduleInfo_progressHandler,false,0,true);
         param1.addEventListener(ModuleEvent.READY,this.moduleInfo_readyHandler,false,0,true);
         return;
      }

      private function moduleInfo_errorHandler(param1:ModuleEvent) : void {
         var _loc2_:ResourceEvent = new ResourceEvent(ResourceEvent.ERROR,param1.bubbles,param1.cancelable);
         _loc2_.bytesLoaded=param1.bytesLoaded;
         _loc2_.bytesTotal=param1.bytesTotal;
         _loc2_.errorText=param1.errorText;
         dispatchEvent(_loc2_);
         return;
      }

      private function moduleInfo_progressHandler(param1:ModuleEvent) : void {
         var _loc2_:ResourceEvent = new ResourceEvent(ResourceEvent.PROGRESS,param1.bubbles,param1.cancelable);
         _loc2_.bytesLoaded=param1.bytesLoaded;
         _loc2_.bytesTotal=param1.bytesTotal;
         dispatchEvent(_loc2_);
         return;
      }

      private function moduleInfo_readyHandler(param1:ModuleEvent) : void {
         var _loc2_:ResourceEvent = new ResourceEvent(ResourceEvent.COMPLETE);
         dispatchEvent(_loc2_);
         return;
      }
   }