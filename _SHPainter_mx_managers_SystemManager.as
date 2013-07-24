package 
{
   import mx.managers.SystemManager;
   import mx.core.IFlexModuleFactory;
   import flashx.textLayout.compose.ISWFContext;
   import mx.core.IFlexModule;
   import flash.system.ApplicationDomain;
   import components.CustomPreloader;
   import flash.utils.Dictionary;
   import __AS3__.vec.Vector;
   import flash.system.Security;
   import mx.events.RSLEvent;
   import flash.display.LoaderInfo;
   import mx.core.FlexVersion;


   public class _SHPainter_mx_managers_SystemManager extends SystemManager implements IFlexModuleFactory, ISWFContext
   {
      public function _SHPainter_mx_managers_SystemManager() {
         FlexVersion.compatibilityVersionString="3.0.0";
         super();
         return;
      }

      override public function callInContext(param1:Function, param2:Object, param3:Array, param4:Boolean=true) : * {
         if(param4)
         {
            return param1.apply(param2,param3);
         }
         param1.apply(param2,param3);
         return;
      }

      override public function create(... rest) : Object {
         if(rest.length > 0 && !(rest[0]  is  String))
         {
            return super.create.apply(this,rest);
         }
         var _loc2_:String = rest.length == 0?"SHPainter":String(rest[0]);
         var _loc3_:Class = Class(getDefinitionByName(_loc2_));
         if(!_loc3_)
         {
            return null;
         }
         var _loc4_:Object = new _loc3_();
         if(_loc4_  is  IFlexModule)
         {
            IFlexModule(_loc4_).moduleFactory=this;
         }
         return _loc4_;
      }

      private var _info:Object;

      override public function info() : Object {
         if(!this._info)
         {
            this._info=
               {
                  "applicationComplete":"init()",
                  "backgroundAlpha":"0.0",
                  "backgroundColor":"0xD8F4FF",
                  "compiledLocales":["en_US"],
                  "compiledResourceBundleNames":["SharedResources","collections","containers","controls","core","effects","formatters","skins","styles","utils"],
                  "currentDomain":ApplicationDomain.currentDomain,
                  "horizontalAlign":"left",
                  "horizontalScrollPolicy":"off",
                  "layout":"absolute",
                  "mainClassName":"SHPainter",
                  "mixins":["_SHPainter_FlexInit","_SHPainter_Styles","mx.managers.systemClasses.ActiveWindowManager"],
                  "paddingLeft":"0",
                  "paddingRight":"0",
                  "paddingTop":"0",
                  "preloader":CustomPreloader,
                  "scriptTimeLimit":"60",
                  "usePreloader":false,
                  "verticalAlign":"top",
                  "verticalScrollPolicy":"off"
               }
            ;
         }
         return this._info;
      }

      private var _preloadedRSLs:Dictionary;

      private var _allowDomainParameters:Vector.<Array>;

      private var _allowInsecureDomainParameters:Vector.<Array>;

      override public function get preloadedRSLs() : Dictionary {
         if(this._preloadedRSLs == null)
         {
            this._preloadedRSLs=new Dictionary(true);
         }
         return this._preloadedRSLs;
      }

      override public function allowDomain(... rest) : void {
         var _loc2_:Object = null;
         Security.allowDomain.apply(null,rest);
         for (_loc2_ in this._preloadedRSLs)
         {
            if((_loc2_.content) && "allowDomainInRSL"  in  _loc2_.content)
            {
               _loc2_.content["allowDomainInRSL"].apply(null,rest);
            }
         }
         if(!this._allowDomainParameters)
         {
            this._allowDomainParameters=new Vector.<Array>();
         }
         this._allowDomainParameters.push(rest);
         addEventListener(RSLEvent.RSL_ADD_PRELOADED,this.addPreloadedRSLHandler,false,50);
         return;
      }

      override public function allowInsecureDomain(... rest) : void {
         var _loc2_:Object = null;
         Security.allowInsecureDomain.apply(null,rest);
         for (_loc2_ in this._preloadedRSLs)
         {
            if((_loc2_.content) && "allowInsecureDomainInRSL"  in  _loc2_.content)
            {
               _loc2_.content["allowInsecureDomainInRSL"].apply(null,rest);
            }
         }
         if(!this._allowInsecureDomainParameters)
         {
            this._allowInsecureDomainParameters=new Vector.<Array>();
         }
         this._allowInsecureDomainParameters.push(rest);
         addEventListener(RSLEvent.RSL_ADD_PRELOADED,this.addPreloadedRSLHandler,false,50);
         return;
      }

      private function addPreloadedRSLHandler(param1:RSLEvent) : void {
         var _loc3_:Array = null;
         var _loc2_:LoaderInfo = param1.loaderInfo;
         if(!_loc2_ || !_loc2_.content)
         {
            return;
         }
         if((allowDomainsInNewRSLs) && (this._allowDomainParameters))
         {
            for each (_loc3_ in this._allowDomainParameters)
            {
               if("allowDomainInRSL"  in  _loc2_.content)
               {
                  _loc2_.content["allowDomainInRSL"].apply(null,_loc3_);
               }
            }
         }
         if((allowInsecureDomainsInNewRSLs) && (this._allowInsecureDomainParameters))
         {
            for each (_loc3_ in this._allowInsecureDomainParameters)
            {
               if("allowInsecureDomainInRSL"  in  _loc2_.content)
               {
                  _loc2_.content["allowInsecureDomainInRSL"].apply(null,_loc3_);
               }
            }
         }
         return;
      }
   }

}