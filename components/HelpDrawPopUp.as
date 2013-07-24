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

   public class HelpDrawPopUp extends Canvas
   {
      public function HelpDrawPopUp() {
         this._documentDescriptor_=new UIComponentDescriptor(
            {
               "type":Canvas,
               "propertiesFactory":new function():Object
               {
                  return {"childDescriptors":[new UIComponentDescriptor(
                     {
                        "type":Canvas,
                        "propertiesFactory":new function():Object
                        {
                           return {
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"on",
                           "height":570,
                           "width":740,
                           "childDescriptors":[new UIComponentDescriptor(
                              {
                                 "type":Image,
                                 "propertiesFactory":new function():Object
                                 {
                                    return {
                                    "x":-20,
                                    "source":_embed_mxml_assets_help_screen_png_64398545
                                 }
                                 ;
                              }
                        }
                        ),new UIComponentDescriptor(
                        {
                              "type":Image,
                              "events":{"mouseDown":"___HelpDrawPopUp_Image2_mouseDown"},
                              "propertiesFactory":new function():Object
                              {
                                 return {
                                 "x":680,
                                 "y":22,
                                 "width":28,
                                 "height":29,
                                 "source":_embed_mxml_assets_cancel_png_511794679,
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
         )]};
         }
         }
         );
         this._embed_mxml_assets_help_screen_png_64398545=HelpDrawPopUp__embed_mxml_assets_help_screen_png_64398545;
         this._embed_mxml_assets_cancel_png_511794679=HelpDrawPopUp__embed_mxml_assets_cancel_png_511794679;
         super();
         mx_internal::_document=this;
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

      public function ___HelpDrawPopUp_Image2_mouseDown(param1:MouseEvent) : void {
         this.close();
         return;
      }

      private var _embed_mxml_assets_help_screen_png_64398545:Class;

      private var _embed_mxml_assets_cancel_png_511794679:Class;
   }

}