package 
{
   import mx.core.Application;
   import mx.core.UIComponent;
   import components.Drawing;
   import components.Editor;
   import mx.controls.Text;
   import mx.core.UIComponentDescriptor;
   import mx.core.IFlexModuleFactory;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.styles.*;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.containers.Canvas;

   use namespace CSSStyleDeclaration;
   use namespace mx_internal;

   public class SHPainter extends Application
   {
      public function SHPainter() {
         this._documentDescriptor_=new UIComponentDescriptor(
            {
               "type":Application,
               "events":{"applicationComplete":"___SHPainter_Application1_applicationComplete"},
               "stylesFactory":new function():void
               {
                  this.backgroundAlpha=0.0;
                  this.backgroundColor=14218495;
                  this.horizontalAlign="left";
                  this.paddingLeft=0;
                  this.paddingRight=0;
                  this.paddingTop=0;
                  this.verticalAlign="top";
                  return;
                  },
                  "propertiesFactory":new function():Object
                  {
                     return {"childDescriptors":[new UIComponentDescriptor(
                        {
                           "type":Canvas,
                           "stylesFactory":new function():void
                           {
                              this.backgroundAlpha=0.0;
                              this.borderColor=14218495;
                              return;
                              },
                              "propertiesFactory":new function():Object
                              {
                                 return {
                                 "x":0,
                                 "y":0,
                                 "childDescriptors":[new UIComponentDescriptor(
                                    {
                                       "type":Text,
                                       "id":"uploadProgress",
                                       "stylesFactory":new function():void
                                       {
                                          this.fontSize=30;
                                          this.fontFamily="arial";
                                          return;
                                          },
                                          "propertiesFactory":new function():Object
                                          {
                                             return {
                                             "selectable":false,
                                             "text":"Loading...",
                                             "alpha":0.5,
                                             "visible":true,
                                             "horizontalCenter":0,
                                             "verticalCenter":0
                                          }
                                          ;
                                       }
                                    }
                                 ),new UIComponentDescriptor(
                                    {
                                       "type":UIComponent,
                                       "id":"_sprite"
                                    }
                                 ),new UIComponentDescriptor(
                                    {
                                       "type":Drawing,
                                       "id":"compDrawing",
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "visible":true,
                                          "horizontalCenter":true,
                                          "verticalCenter":"top"
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Editor,
                                    "id":"compEditor",
                                    "propertiesFactory":new function():Object
                                    {
                                       return {
                                       "visible":false,
                                       "horizontalCenter":true,
                                       "verticalCenter":true
                                    }
                                    ;
                              }
                           }
                           )]
                        }
                        ;
                  }
               }
               )]};
            }
         }
         );
         this._1660521369categoriesXmlList=new XMLList();
         super();
         mx_internal::_document=this;
         this.horizontalScrollPolicy="off";
         this.verticalScrollPolicy="off";
         this.layout="absolute";
         this.addEventListener("applicationComplete",this.___SHPainter_Application1_applicationComplete);
         return;
      }

      private var _1812791268_sprite:UIComponent;

      private var _382804465compDrawing:Drawing;

      private var _1658981028compEditor:Editor;

      private var _1534483634uploadProgress:Text;

      private var _documentDescriptor_:UIComponentDescriptor;

      private var __moduleFactoryInitialized:Boolean = false;

      override public function set moduleFactory(param1:IFlexModuleFactory) : void {
         var factory:IFlexModuleFactory = param1;
         super.moduleFactory=factory;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized=true;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration=new CSSStyleDeclaration(null,styleManager);
         }
         this.styleDeclaration.defaultFactory=new function():void
         {
            this.backgroundAlpha=0.0;
            this.backgroundColor=14218495;
            this.horizontalAlign="left";
            this.paddingLeft=0;
            this.paddingRight=0;
            this.paddingTop=0;
            this.verticalAlign="top";
            return;
         };
         mx_internal::_SHPainter_StylesInit();
         return;
      }

      override public function initialize() : void {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
         return;
      }

      private var _1660521369categoriesXmlList:XMLList;

      private var ticTacTiObj:Object;

      private function init() : void {
         Security.allowDomain("*");
         var _loc1_:Number = 3170;
         var _loc2_:* = "cleanapi";
         var _loc3_:* = "flash_video_player";
         var _loc4_:* = "-1952520052";
         this.initPainter();
         return;
      }

      public function loadTicTacTiSwf(param1:String, param2:int, param3:Function, param4:DisplayObjectContainer, param5:String=null, param6:URLVariables=null) : DisplayObject {
         var _loc7_:Loader = new Loader();
         var _loc8_:URLRequest = new URLRequest(param1);
         if(param5 != null)
         {
            _loc8_.method=param5;
         }
         if(param6 != null)
         {
            _loc8_.data=param6;
         }
         _loc7_.contentLoaderInfo.addEventListener(Event.COMPLETE,param3);
         _loc7_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,param3);
         _loc7_.load(_loc8_);
         if(param4 != null)
         {
            if(param2 < 0)
            {
               param4.addChild(_loc7_);
            }
            else
            {
               param4.addChildAt(_loc7_,param2);
            }
         }
         return _loc7_;
      }

      protected function onEngineLoaded(param1:Event) : void {
         if(param1.type == IOErrorEvent.IO_ERROR)
         {
            this.initPainter();
            return;
         }
         var _loc2_:* = param1.target.content;
         _loc2_.Init();
         this.ticTacTiObj=_loc2_.EngineObj;
         this.ticTacTiObj.addEventListener("INIT_DONE",this.onEngineReady);
         this.ticTacTiObj.addEventListener("AD_CLOSED",this.onAdClosed);
         return;
      }

      private function onAdClosed(param1:Event) : void {
         this._sprite.visible=0;
         this._sprite.height=0;
         this.initPainter();
         return;
      }

      private function onEngineReady(param1:Event) : void {
         this.onAdClosed(null);
         return;
      }

      private function initPainter() : void {
         this.compDrawing.visible=false;
         this.compEditor.visible=false;
         this.compDrawing.visible=true;
         this.compDrawing.addEventListener(Drawing.OPEN_EDITOR,this.openEditor);
         this.compEditor.addEventListener(Editor.OPEN_DRAWING,this.openDrawing);
         var _loc1_:URLLoader = new URLLoader();
         var _loc2_:URLRequest = new URLRequest("categories.php?tmp=" + Math.random());
         _loc1_.load(_loc2_);
         _loc1_.addEventListener(Event.COMPLETE,this.categoriesLoaded);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         return;
      }

      public function categoriesLoaded(param1:Event) : void {
         this.categoriesXmlList=XML(param1.target.data).children();
         return;
      }

      public function ioErrorHandler(param1:IOErrorEvent) : void {
         return;
      }

      private function openEditor(param1:Event) : void {
         this.compDrawing.visible=false;
         this.compEditor.visible=true;
         var _loc2_:int = Application.application.parameters.user_id;
         var _loc3_:String = Application.application.parameters.save_url;
         this.compEditor.init(_loc2_,_loc3_);
         return;
      }

      private function openDrawing(param1:Event) : void {
         this.compEditor.visible=false;
         this.compDrawing.visible=true;
         return;
      }

      public function ___SHPainter_Application1_applicationComplete(param1:FlexEvent) : void {
         this.init();
         return;
      }

      mx_internal var _SHPainter_StylesInit_done:Boolean = false;

      mx_internal function _SHPainter_StylesInit() : void {
         var _loc1_:CSSStyleDeclaration = null;
         var _loc2_:Array = null;
         if(mx_internal::_SHPainter_StylesInit_done)
         {
            return;
         }
         mx_internal::_SHPainter_StylesInit_done=true;
         styleManager.initProtoChainRoots();
         return;
      }

      public function get _sprite() : UIComponent {
         return this._1812791268_sprite;
      }

      public function set _sprite(param1:UIComponent) : void {
         var _loc2_:Object = this._1812791268_sprite;
         if(_loc2_ !== param1)
         {
            this._1812791268_sprite=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sprite",_loc2_,param1));
            }
         }
         return;
      }

      public function get compDrawing() : Drawing {
         return this._382804465compDrawing;
      }

      public function set compDrawing(param1:Drawing) : void {
         var _loc2_:Object = this._382804465compDrawing;
         if(_loc2_ !== param1)
         {
            this._382804465compDrawing=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"compDrawing",_loc2_,param1));
            }
         }
         return;
      }

      public function get compEditor() : Editor {
         return this._1658981028compEditor;
      }

      public function set compEditor(param1:Editor) : void {
         var _loc2_:Object = this._1658981028compEditor;
         if(_loc2_ !== param1)
         {
            this._1658981028compEditor=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"compEditor",_loc2_,param1));
            }
         }
         return;
      }

      public function get uploadProgress() : Text {
         return this._1534483634uploadProgress;
      }

      public function set uploadProgress(param1:Text) : void {
         var _loc2_:Object = this._1534483634uploadProgress;
         if(_loc2_ !== param1)
         {
            this._1534483634uploadProgress=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"uploadProgress",_loc2_,param1));
            }
         }
         return;
      }

      public function get categoriesXmlList() : XMLList {
         return this._1660521369categoriesXmlList;
      }

      public function set categoriesXmlList(param1:XMLList) : void {
         var _loc2_:Object = this._1660521369categoriesXmlList;
         if(_loc2_ !== param1)
         {
            this._1660521369categoriesXmlList=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"categoriesXmlList",_loc2_,param1));
            }
         }
         return;
      }
   }

}