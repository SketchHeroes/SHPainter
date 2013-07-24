package components
{
   import mx.containers.Canvas;
   import mx.controls.ComboBox;
   import mx.controls.TextArea;
   import mx.controls.TextInput;
   import mx.core.UIComponentDescriptor;
   import mx.core.IFlexModuleFactory;
   import mx.core.mx_internal;
   import com.reinatech.player.events.PublishEvent;
   import mx.core.Application;
   import mx.binding.*;
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
   import mx.styles.*;
   import mx.events.PropertyChangeEvent;
   import mx.controls.Image;

   use namespace mx_internal;
   use namespace StyleManager;

   public class Publish extends Canvas implements IBindingClient
   {
      public function Publish() {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_=new UIComponentDescriptor(
            {
               "type":Canvas,
               "propertiesFactory":new function():Object
               {
                  return {"childDescriptors":[new UIComponentDescriptor(
                     {
                        "type":Image,
                        "propertiesFactory":new function():Object
                        {
                           return {
                           "x":0,
                           "y":10,
                           "width":400,
                           "height":505,
                           "source":_embed_mxml_assets_share_share_bg_f_png_1843346912
                        }
                        ;
                     }
               }
               ),new UIComponentDescriptor(
               {
                     "type":Image,
                     "events":{"mouseDown":"___Publish_Image2_mouseDown"},
                     "propertiesFactory":new function():Object
                     {
                        return {
                        "x":358,
                        "y":36,
                        "width":11,
                        "height":11,
                        "source":_embed_mxml_assets_editor_publish_x_png_1426614889,
                        "buttonMode":true
                     }
                     ;
               }
            }
            ),new UIComponentDescriptor(
            {
               "type":TextInput,
               "id":"txtTitle",
               "stylesFactory":new function():void
               {
                     this.backgroundAlpha=0.0;
                     this.borderColor=16777215;
                     this.borderStyle="none";
                     this.themeColor=16777215;
                     return;
                     },
                     "propertiesFactory":new function():Object
                     {
                        return {
                        "x":55,
                        "y":106,
                        "width":294,
                        "height":24,
                        "maxChars":100
                     }
                     ;
               }
            }
            ),new UIComponentDescriptor(
            {
               "type":TextArea,
               "id":"txtDescription",
               "stylesFactory":new function():void
               {
                     this.backgroundAlpha=0.0;
                     this.borderStyle="none";
                     return;
                     },
                     "propertiesFactory":new function():Object
                     {
                        return {
                        "x":55,
                        "y":169,
                        "width":294,
                        "height":119
                     }
                     ;
               }
            }
            ),new UIComponentDescriptor(
            {
               "type":ComboBox,
               "id":"categories",
               "propertiesFactory":new function():Object
               {
                     return {
                     "x":50,
                     "y":328,
                     "width":299,
                     "height":29,
                     "labelField":"@name"
               }
               ;
            }
         }
         ),new UIComponentDescriptor(
         {
            "type":Image,
            "events":{"mouseDown":"___Publish_Image3_mouseDown"},
            "propertiesFactory":new function():Object
            {
               return {
               "x":142,
               "y":375,
               "source":_embed_mxml_assets_share_share_button_PNG_1673277692,
               "buttonMode":true
            }
            ;
         }
         }
         )]};
         }
         }
         );
         this._embed_mxml_assets_editor_publish_x_png_1426614889=Publish__embed_mxml_assets_editor_publish_x_png_1426614889;
         this._embed_css____assets_editor_publish_window_png_464586542_1447855570=_class_embed_css____assets_editor_publish_window_png_464586542_1447855570;
         this._embed_css____assets_editor_publish_combo_png_230539622_514469018=_class_embed_css____assets_editor_publish_combo_png_230539622_514469018;
         this._embed_mxml_assets_share_share_bg_f_png_1843346912=Publish__embed_mxml_assets_share_share_bg_f_png_1843346912;
         this._embed_css____assets_editor_publish_mid_window_png__1698774394_306028042=_class_embed_css____assets_editor_publish_mid_window_png__1698774394_306028042;
         this._embed_mxml_assets_share_share_button_PNG_1673277692=Publish__embed_mxml_assets_share_share_button_PNG_1673277692;
         this._bindings=[];
         this._watchers=[];
         this._bindingsByDestination={};
         this._bindingsBeginWithWord={};
         super();
         mx_internal::_document=this;
         var bindings:Array = this._Publish_bindingsSetup();
         var watchers:Array = [];
         target=this;
         if(_watcherSetupUtil == null)
         {
         watcherSetupUtilClass=getDefinitionByName("_components_PublishWatcherSetupUtil");
         watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,new function(param1:String):*
         {
         return target[param1];
         },new function(param1:String):*
         {
         return Publish[param1];
         },bindings,watchers);
         mx_internal::_bindings=mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers=mx_internal::_watchers.concat(watchers);
         var i:uint = 0;
         while(i < bindings.length)
         {
         Binding(bindings[i]).execute();
         i++;
         }
         return;
      }

      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void {
         Publish._watcherSetupUtil=param1;
         return;
      }

      private static var _watcherSetupUtil:IWatcherSetupUtil2;

      private var _1296516636categories:ComboBox;

      private var _1626832020txtDescription:TextArea;

      private var _1464371768txtTitle:TextInput;

      private var _documentDescriptor_:UIComponentDescriptor;

      private var __moduleFactoryInitialized:Boolean = false;

      override public function set moduleFactory(param1:IFlexModuleFactory) : void {
         super.moduleFactory=param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized=true;
         mx_internal::_Publish_StylesInit();
         return;
      }

      override public function initialize() : void {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
         return;
      }

      private function close() : void {
         dispatchEvent(new Event(Event.CLOSE,true,false));
         return;
      }

      private function publish() : void {
         if(this.txtTitle.text == "")
         {
            this.txtTitle.setFocus();
            return;
         }
         if(this.txtDescription.text == "")
         {
            this.txtDescription.setFocus();
            return;
         }
         dispatchEvent(new PublishEvent(PublishEvent.PUBLISH,true,false,this.txtTitle.text,this.txtDescription.text,Application.application.categoriesXmlList[this.categories.selectedIndex].@name));
         return;
      }

      public function ___Publish_Image2_mouseDown(param1:MouseEvent) : void {
         this.close();
         return;
      }

      public function ___Publish_Image3_mouseDown(param1:MouseEvent) : void {
         this.publish();
         return;
      }

      private function _Publish_bindingsSetup() : Array {
         var result:Array = [];
         result[0]=new Binding(this,new function():Object
         {
            return Application.application.categoriesXmlList;
            },null,"categories.dataProvider");
            return result;
      }

      mx_internal var _Publish_StylesInit_done:Boolean = false;

      mx_internal function _Publish_StylesInit() : void {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_Publish_StylesInit_done)
         {
            return;
         }
         mx_internal::_Publish_StylesInit_done=true;
         style=styleManager.getStyleDeclaration(".titleInput");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".titleInput",style,false);
         }
         if(style.factory == null)
         {
            style.factory=new function():void
            {
               this.backgroundImage=_embed_css____assets_editor_publish_window_png_464586542_1447855570;
               return;
            };
         }
         style=styleManager.getStyleDeclaration(".descriptionInput");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".descriptionInput",style,false);
         }
         if(style.factory == null)
         {
            style.factory=new function():void
            {
               this.backgroundImage=_embed_css____assets_editor_publish_mid_window_png__1698774394_306028042;
               return;
            };
         }
         style=styleManager.getStyleDeclaration(".categoriesCombo");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".categoriesCombo",style,false);
         }
         if(style.factory == null)
         {
            style.factory=new function():void
            {
               this.upSkin=_embed_css____assets_editor_publish_combo_png_230539622_514469018;
               this.downSkin=_embed_css____assets_editor_publish_combo_png_230539622_514469018;
               this.overSkin=_embed_css____assets_editor_publish_combo_png_230539622_514469018;
               return;
            };
         }
         return;
      }

      private var _embed_mxml_assets_editor_publish_x_png_1426614889:Class;

      private var _embed_css____assets_editor_publish_window_png_464586542_1447855570:Class;

      private var _embed_css____assets_editor_publish_combo_png_230539622_514469018:Class;

      private var _embed_mxml_assets_share_share_bg_f_png_1843346912:Class;

      private var _embed_css____assets_editor_publish_mid_window_png__1698774394_306028042:Class;

      private var _embed_mxml_assets_share_share_button_PNG_1673277692:Class;

      mx_internal var _bindings:Array;

      mx_internal var _watchers:Array;

      mx_internal var _bindingsByDestination:Object;

      mx_internal var _bindingsBeginWithWord:Object;

      public function get categories() : ComboBox {
         return this._1296516636categories;
      }

      public function set categories(param1:ComboBox) : void {
         var _loc2_:Object = this._1296516636categories;
         if(_loc2_ !== param1)
         {
            this._1296516636categories=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"categories",_loc2_,param1));
            }
         }
         return;
      }

      public function get txtDescription() : TextArea {
         return this._1626832020txtDescription;
      }

      public function set txtDescription(param1:TextArea) : void {
         var _loc2_:Object = this._1626832020txtDescription;
         if(_loc2_ !== param1)
         {
            this._1626832020txtDescription=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtDescription",_loc2_,param1));
            }
         }
         return;
      }

      public function get txtTitle() : TextInput {
         return this._1464371768txtTitle;
      }

      public function set txtTitle(param1:TextInput) : void {
         var _loc2_:Object = this._1464371768txtTitle;
         if(_loc2_ !== param1)
         {
            this._1464371768txtTitle=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtTitle",_loc2_,param1));
            }
         }
         return;
      }
   }

}