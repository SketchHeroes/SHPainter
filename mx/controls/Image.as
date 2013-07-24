package mx.controls
{
   import mx.core.IDataRenderer;
   import mx.controls.listClasses.IDropInListItemRenderer;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.controls.listClasses.BaseListData;
   import flash.events.Event;
   import flash.display.DisplayObject;

   use namespace mx_internal;

   public class Image extends SWFLoader implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer
   {
      public function Image() {
         super();
         tabChildren=false;
         tabEnabled=true;
         tabFocusEnabled=true;
         showInAutomationHierarchy=true;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private var makeContentVisible:Boolean = false;

      private var sourceSet:Boolean;

      private var settingBrokenImage:Boolean;

      override public function set source(param1:Object) : void {
         this.settingBrokenImage=param1 == getStyle("brokenImageSkin");
         this.sourceSet=!this.settingBrokenImage;
         super.source=param1;
         return;
      }

      private var _data:Object;

      public function get data() : Object {
         return this._data;
      }

      public function set data(param1:Object) : void {
         this._data=param1;
         if(!this.sourceSet)
         {
            this.source=this.listData?this.listData.label:this.data;
            this.sourceSet=false;
         }
         dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
         return;
      }

      private var _listData:BaseListData;

      public function get listData() : BaseListData {
         return this._listData;
      }

      public function set listData(param1:BaseListData) : void {
         this._listData=param1;
         return;
      }

      override public function invalidateSize() : void {
         if((this.data) && (this.settingBrokenImage))
         {
            return;
         }
         super.invalidateSize();
         return;
      }

      override protected function updateDisplayList(param1:Number, param2:Number) : void {
         super.updateDisplayList(param1,param2);
         if((this.makeContentVisible) && (contentHolder))
         {
            contentHolder.visible=true;
            this.makeContentVisible=false;
         }
         return;
      }

      override mx_internal function contentLoaderInfo_completeEventHandler(param1:Event) : void {
         var _loc2_:DisplayObject = DisplayObject(param1.target.loader);
         super.contentLoaderInfo_completeEventHandler(param1);
         _loc2_.visible=false;
         this.makeContentVisible=true;
         invalidateDisplayList();
         return;
      }
   }

}