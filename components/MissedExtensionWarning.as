package components
{
   import mx.containers.Canvas;
   import mx.core.UIComponentDescriptor;
   import mx.core.IFlexModuleFactory;
   import mx.core.mx_internal;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mx.controls.Image;

   use namespace mx_internal;

   public class MissedExtensionWarning extends Canvas
   {
      public function MissedExtensionWarning() {
         this._documentDescriptor_=new UIComponentDescriptor(
            {
               "type":Canvas,
               "propertiesFactory":new function():Object
               {
                  return {
                  "width":531,
                  "height":339,
                  "childDescriptors":[new UIComponentDescriptor(
                     {
                        "type":Image,
                        "propertiesFactory":new function():Object
                        {
                           return {
                           "width":342,
                           "height":134,
                           "source":_embed_mxml_assets_save_png_1364666863
                        }
                        ;
                     }
               }
               ),new UIComponentDescriptor(
               {
                     "type":Image,
                     "events":{"mouseDown":"___MissedExtensionWarning_Image2_mouseDown"},
                     "propertiesFactory":new function():Object
                     {
                        return {
                        "x":316,
                        "y":0,
                        "width":16,
                        "height":16,
                        "source":_embed_mxml_assets_delete_png_511941815,
                        "buttonMode":true
                     }
                     ;
               }
            }
            )]
         }
         ;
         }
         }
         );
         this._embed_mxml_assets_save_png_1364666863=MissedExtensionWarning__embed_mxml_assets_save_png_1364666863;
         this._embed_mxml_assets_delete_png_511941815=MissedExtensionWarning__embed_mxml_assets_delete_png_511941815;
         super();
         mx_internal::_document=this;
         this.width=531;
         this.height=339;
         return;
      }

      private var _documentDescriptor_:UIComponentDescriptor;

      private var __moduleFactoryInitialized:Boolean = false;

      override public function set moduleFactory(param1:IFlexModuleFactory) : void {
         super.moduleFactory=param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized=true;
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

      public function ___MissedExtensionWarning_Image2_mouseDown(param1:MouseEvent) : void {
         this.close();
         return;
      }

      private var _embed_mxml_assets_save_png_1364666863:Class;

      private var _embed_mxml_assets_delete_png_511941815:Class;
   }

}