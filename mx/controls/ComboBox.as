package mx.controls
{
   import mx.core.IDataRenderer;
   import mx.controls.listClasses.IDropInListItemRenderer;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.core.mx_internal;
   import mx.controls.listClasses.ListBase;
   import mx.effects.Tween;
   import flash.events.Event;
   import mx.controls.dataGridClasses.DataGridListData;
   import mx.controls.listClasses.ListData;
   import mx.events.FlexEvent;
   import mx.controls.listClasses.BaseListData;
   import mx.core.IFactory;
   import mx.core.EdgeMetrics;
   import mx.managers.PopUpManager;
   import mx.collections.ArrayCollection;
   import mx.core.ScrollPolicy;
   import mx.events.ScrollEvent;
   import mx.events.ListEvent;
   import mx.core.UIComponentGlobals;
   import mx.utils.MatrixUtil;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import mx.managers.ISystemManager;
   import flash.geom.Rectangle;
   import mx.events.FlexMouseEvent;
   import mx.events.SandboxMouseEvent;
   import mx.core.LayoutDirection;
   import mx.core.UIComponent;
   import mx.events.CollectionEvent;
   import mx.events.CollectionEventKind;
   import flash.events.MouseEvent;
   import flash.events.FocusEvent;
   import flash.display.DisplayObject;
   import mx.events.ScrollEventDetail;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import mx.events.DropdownEvent;
   import flash.text.TextLineMetrics;
   import mx.collections.CursorBookmark;
   import mx.core.ClassFactory;

   use namespace mx_internal;

   public class ComboBox extends ComboBase implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer
   {
      public function ComboBox() {
         this._dropdownFactory=new ClassFactory(List);
         super();
         this.dataProvider=new ArrayCollection();
         useFullDropdownSkin=true;
         wrapDownArrowButton=false;
         addEventListener("unload",this.unloadHandler);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      mx_internal  static var createAccessibilityImplementation:Function;

      private var _dropdown:ListBase;

      private var _oldIndex:int;

      private var tween:Tween = null;

      private var tweenUp:Boolean = false;

      private var preferredDropdownWidth:Number;

      private var dropdownBorderStyle:String = "solid";

      private var _showingDropdown:Boolean = false;

      private var _selectedIndexOnDropdown:int = -1;

      private var bRemoveDropdown:Boolean = true;

      private var inTween:Boolean = false;

      private var bInKeyDown:Boolean = false;

      private var selectedItemSet:Boolean;

      private var triggerEvent:Event;

      private var explicitText:Boolean;

      private var _data:Object;

      public function get data() : Object {
         return this._data;
      }

      public function set data(param1:Object) : void {
         var _loc2_:* = undefined;
         this._data=param1;
         if((this._listData) && this._listData  is  DataGridListData)
         {
            _loc2_=this._data[DataGridListData(this._listData).dataField];
         }
         else
         {
            if(this._listData  is  ListData && ListData(this._listData).labelField  in  this._data)
            {
               _loc2_=this._data[ListData(this._listData).labelField];
            }
            else
            {
               _loc2_=this._data;
            }
         }
         if(!(_loc2_ === undefined) && !this.selectedItemSet)
         {
            this.selectedItem=_loc2_;
            this.selectedItemSet=false;
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

      private var collectionChanged:Boolean = false;

      override public function set dataProvider(param1:Object) : void {
         selectionChanged=true;
         super.dataProvider=param1;
         this.destroyDropdown();
         invalidateProperties();
         invalidateSize();
         return;
      }

      private var _itemRenderer:IFactory;

      public function get itemRenderer() : IFactory {
         return this._itemRenderer;
      }

      public function set itemRenderer(param1:IFactory) : void {
         this._itemRenderer=param1;
         if(this._dropdown)
         {
            this._dropdown.itemRenderer=param1;
         }
         invalidateSize();
         invalidateDisplayList();
         dispatchEvent(new Event("itemRendererChanged"));
         return;
      }

      override public function set selectedIndex(param1:int) : void {
         super.selectedIndex=param1;
         if(param1 >= 0)
         {
            selectionChanged=true;
         }
         this.implicitSelectedIndex=false;
         invalidateDisplayList();
         if((textInput) && (!textChanged) && param1 >= 0)
         {
            textInput.text=this.selectedLabel;
         }
         else
         {
            if((textInput) && (this.prompt))
            {
               textInput.text=this.prompt;
            }
         }
         return;
      }

      override public function set selectedItem(param1:Object) : void {
         this.selectedItemSet=true;
         this.implicitSelectedIndex=false;
         super.selectedItem=param1;
         return;
      }

      override public function set showInAutomationHierarchy(param1:Boolean) : void {
         return;
      }

      public function get dropdown() : ListBase {
         return this.getDropdown();
      }

      private var _dropdownFactory:IFactory;

      public function get dropdownFactory() : IFactory {
         return this._dropdownFactory;
      }

      public function set dropdownFactory(param1:IFactory) : void {
         this._dropdownFactory=param1;
         dispatchEvent(new Event("dropdownFactoryChanged"));
         return;
      }

      protected function get dropDownStyleFilters() : Object {
         return null;
      }

      private var _dropdownWidth:Number = 100;

      public function get dropdownWidth() : Number {
         return this._dropdownWidth;
      }

      public function set dropdownWidth(param1:Number) : void {
         this._dropdownWidth=param1;
         this.preferredDropdownWidth=param1;
         if(this._dropdown)
         {
            this._dropdown.setActualSize(param1,this._dropdown.height);
         }
         dispatchEvent(new Event("dropdownWidthChanged"));
         return;
      }

      private var _labelField:String = "label";

      private var labelFieldChanged:Boolean;

      public function get labelField() : String {
         return this._labelField;
      }

      public function set labelField(param1:String) : void {
         this._labelField=param1;
         this.labelFieldChanged=true;
         invalidateDisplayList();
         dispatchEvent(new Event("labelFieldChanged"));
         return;
      }

      private var _labelFunction:Function;

      private var labelFunctionChanged:Boolean;

      public function get labelFunction() : Function {
         return this._labelFunction;
      }

      public function set labelFunction(param1:Function) : void {
         this._labelFunction=param1;
         this.labelFunctionChanged=true;
         invalidateDisplayList();
         dispatchEvent(new Event("labelFunctionChanged"));
         return;
      }

      private var promptChanged:Boolean = false;

      private var _prompt:String;

      public function get prompt() : String {
         return this._prompt;
      }

      public function set prompt(param1:String) : void {
         this._prompt=param1;
         this.promptChanged=true;
         invalidateProperties();
         return;
      }

      private var _rowCount:int = 5;

      public function get rowCount() : int {
         return Math.max(1,Math.min(collection.length,this._rowCount));
      }

      public function set rowCount(param1:int) : void {
         this._rowCount=param1;
         if(this._dropdown)
         {
            this._dropdown.rowCount=param1;
         }
         return;
      }

      public function get selectedLabel() : String {
         var _loc1_:Object = selectedItem;
         return this.itemToLabel(_loc1_);
      }

      override protected function initializeAccessibility() : void {
         if(ComboBox.createAccessibilityImplementation != null)
         {
            ComboBox.createAccessibilityImplementation(this);
         }
         return;
      }

      override public function styleChanged(param1:String) : void {
         this.destroyDropdown();
         super.styleChanged(param1);
         return;
      }

      override protected function measure() : void {
         super.measure();
         measuredMinWidth=Math.max(measuredWidth,DEFAULT_MEASURED_MIN_WIDTH);
         var _loc1_:Number = measureText("M").height + 6;
         var _loc2_:EdgeMetrics = borderMetrics;
         measuredMinHeight=measuredHeight=Math.max(_loc1_ + _loc2_.top + _loc2_.bottom,DEFAULT_MEASURED_MIN_HEIGHT);
         measuredMinHeight=measuredHeight=measuredHeight + (getStyle("paddingTop") + getStyle("paddingBottom"));
         return;
      }

      override protected function updateDisplayList(param1:Number, param2:Number) : void {
         super.updateDisplayList(param1,param2);
         if((this._dropdown) && !this.inTween)
         {
            if(!this._showingDropdown)
            {
               this.destroyDropdown();
            }
         }
         else
         {
            if(this._showingDropdown)
            {
               this.bRemoveDropdown=false;
            }
         }
         var _loc3_:Number = this.preferredDropdownWidth;
         if(isNaN(_loc3_))
         {
            _loc3_=this._dropdownWidth=param1;
         }
         if(this.labelFieldChanged)
         {
            if(this._dropdown)
            {
               this._dropdown.labelField=this._labelField;
            }
            selectionChanged=true;
            if(!this.explicitText)
            {
               textInput.text=this.selectedLabel;
            }
            this.labelFieldChanged=false;
         }
         if(this.labelFunctionChanged)
         {
            selectionChanged=true;
            if(!this.explicitText)
            {
               textInput.text=this.selectedLabel;
            }
            this.labelFunctionChanged=false;
         }
         if(selectionChanged)
         {
            if(!textChanged)
            {
               if(selectedIndex == -1 && (this.prompt))
               {
                  textInput.text=this.prompt;
               }
               else
               {
                  if(!this.explicitText)
                  {
                     textInput.text=this.selectedLabel;
                  }
               }
            }
            textInput.invalidateDisplayList();
            textInput.validateNow();
            if(editable)
            {
               textInput.selectRange(0,textInput.text.length);
               textInput.horizontalScrollPosition=0;
            }
            if(this._dropdown)
            {
               this._dropdown.selectedIndex=selectedIndex;
            }
            selectionChanged=false;
         }
         if((this._dropdown) && !(this._dropdown.rowCount == this.rowCount))
         {
            this._dropdown.rowCount=this.rowCount;
         }
         return;
      }

      override protected function commitProperties() : void {
         this.explicitText=textChanged;
         super.commitProperties();
         if(this.collectionChanged)
         {
            if(selectedIndex == -1 && (this.implicitSelectedIndex) && this._prompt == null)
            {
               this.selectedIndex=0;
            }
            selectedIndexChanged=true;
            this.collectionChanged=false;
         }
         if((this.promptChanged) && !(this.prompt == null) && selectedIndex == -1)
         {
            this.promptChanged=false;
            textInput.text=this.prompt;
         }
         return;
      }

      public function itemToLabel(param1:Object, ... rest) : String {
         if(param1 == null)
         {
            return "";
         }
         if(this.labelFunction != null)
         {
            return this.labelFunction(param1);
         }
         if(typeof param1 == "object")
         {
            try
            {
               if(param1[this.labelField] != null)
               {
                  param1=param1[this.labelField];
               }
            }
            catch(e:Error)
            {
            }
         }
         else
         {
            if(typeof param1 == "xml")
            {
               try
               {
                  if(param1[this.labelField].length() != 0)
                  {
                     param1=param1[this.labelField];
                  }
               }
               catch(e:Error)
               {
               }
            }
         }
         if(typeof param1 == "string")
         {
            return String(param1);
         }
         try
         {
            return param1.toString();
         }
         catch(e:Error)
         {
         }
         return " ";
      }

      public function open() : void {
         this.displayDropdown(true);
         return;
      }

      public function close(param1:Event=null) : void {
         if(this._showingDropdown)
         {
            if((this._dropdown) && !(selectedIndex == this._dropdown.selectedIndex))
            {
               this.selectedIndex=this._dropdown.selectedIndex;
            }
            this.displayDropdown(false,param1);
            this.dispatchChangeEvent(new Event("dummy"),this._selectedIndexOnDropdown,selectedIndex);
         }
         return;
      }

      mx_internal function hasDropdown() : Boolean {
         return !(this._dropdown == null);
      }

      private function getDropdown() : ListBase {
         var _loc2_:String = null;
         if(!initialized)
         {
            return null;
         }
         if(!this.hasDropdown())
         {
            _loc2_=getStyle("dropDownStyleName");
            if(_loc2_ == null)
            {
               _loc2_=getStyle("dropdownStyleName");
            }
            this._dropdown=this.dropdownFactory.newInstance();
            this._dropdown.visible=false;
            this._dropdown.focusEnabled=false;
            this._dropdown.owner=this;
            if(this.itemRenderer)
            {
               this._dropdown.itemRenderer=this.itemRenderer;
            }
            if(_loc2_)
            {
               this._dropdown.styleName=_loc2_;
            }
            PopUpManager.addPopUp(this._dropdown,this);
            this._dropdown.setStyle("selectionDuration",0);
            if(!dataProvider)
            {
               this.dataProvider=new ArrayCollection();
            }
            this._dropdown.dataProvider=dataProvider;
            this._dropdown.rowCount=this.rowCount;
            this._dropdown.width=this._dropdownWidth;
            this._dropdown.selectedIndex=selectedIndex;
            this._oldIndex=selectedIndex;
            this._dropdown.verticalScrollPolicy=ScrollPolicy.AUTO;
            this._dropdown.labelField=this._labelField;
            this._dropdown.labelFunction=this.itemToLabel;
            this._dropdown.allowDragSelection=true;
            this._dropdown.addEventListener("change",this.dropdown_changeHandler);
            this._dropdown.addEventListener(ScrollEvent.SCROLL,this.dropdown_scrollHandler);
            this._dropdown.addEventListener(ListEvent.ITEM_ROLL_OVER,this.dropdown_itemRollOverHandler);
            this._dropdown.addEventListener(ListEvent.ITEM_ROLL_OUT,this.dropdown_itemRollOutHandler);
            this._dropdown.addEventListener(ListEvent.ITEM_CLICK,this.dropdown_itemClickHandler);
            UIComponentGlobals.layoutManager.validateClient(this._dropdown,true);
            this._dropdown.setActualSize(this._dropdownWidth,this._dropdown.getExplicitOrMeasuredHeight());
            this._dropdown.validateDisplayList();
            this._dropdown.cacheAsBitmap=true;
            systemManager.addEventListener(Event.RESIZE,this.stage_resizeHandler,false,0,true);
         }
         var _loc1_:Matrix = MatrixUtil.getConcatenatedMatrix(this,systemManager.getSandboxRoot());
         this._dropdown.scaleX=_loc1_.a;
         this._dropdown.scaleY=_loc1_.d;
         return this._dropdown;
      }

      private function displayDropdown(param1:Boolean, param2:Event=null, param3:Boolean=true) : void {
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:Function = null;
         var _loc11_:* = 0;
         var _loc12_:* = NaN;
         if(!initialized || param1 == this._showingDropdown)
         {
            return;
         }
         if(this.inTween)
         {
            this.tween.endTween();
         }
         var _loc8_:Point = new Point(0,unscaledHeight);
         _loc8_=localToGlobal(_loc8_);
         var _loc9_:ISystemManager = systemManager.topLevelSystemManager;
         var _loc10_:Rectangle = _loc9_.getVisibleApplicationRect(null,true);
         if(param1)
         {
            this._selectedIndexOnDropdown=selectedIndex;
            this.getDropdown();
            this._dropdown.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE,this.dropdown_mouseOutsideHandler);
            this._dropdown.addEventListener(FlexMouseEvent.MOUSE_WHEEL_OUTSIDE,this.dropdown_mouseOutsideHandler);
            this._dropdown.addEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE,this.dropdown_mouseOutsideHandler);
            this._dropdown.addEventListener(SandboxMouseEvent.MOUSE_WHEEL_SOMEWHERE,this.dropdown_mouseOutsideHandler);
            if(this._dropdown.parent == null)
            {
               PopUpManager.addPopUp(this._dropdown,this);
            }
            else
            {
               PopUpManager.bringToFront(this._dropdown);
            }
            if(_loc8_.y + this._dropdown.height > _loc10_.bottom && _loc8_.y > _loc10_.top + this._dropdown.height)
            {
               _loc8_.y=_loc8_.y - (unscaledHeight + this._dropdown.height);
               _loc4_=-this._dropdown.height;
               this.tweenUp=true;
            }
            else
            {
               _loc4_=this._dropdown.height;
               this.tweenUp=false;
            }
            _loc8_=this._dropdown.parent.globalToLocal(_loc8_);
            if(layoutDirection == LayoutDirection.RTL)
            {
               _loc8_.x=_loc8_.x - this._dropdown.width;
            }
            _loc11_=this._dropdown.selectedIndex;
            if(_loc11_ == -1)
            {
               _loc11_=0;
            }
            _loc12_=this._dropdown.verticalScrollPosition;
            _loc12_=_loc11_-1;
            _loc12_=Math.min(Math.max(_loc12_,0),this._dropdown.maxVerticalScrollPosition);
            this._dropdown.verticalScrollPosition=_loc12_;
            if(!(this._dropdown.x == _loc8_.x) || !(this._dropdown.y == _loc8_.y))
            {
               this._dropdown.move(_loc8_.x,_loc8_.y);
            }
            this._dropdown.scrollRect=new Rectangle(0,_loc4_,this._dropdown.width,this._dropdown.height);
            if(!this._dropdown.visible)
            {
               this._dropdown.visible=true;
            }
            this.bRemoveDropdown=false;
            this._showingDropdown=param1;
            _loc6_=getStyle("openDuration");
            _loc5_=0;
            _loc7_=getStyle("openEasingFunction") as Function;
         }
         else
         {
            if(this._dropdown)
            {
               _loc5_=_loc8_.y + this._dropdown.height > _loc10_.bottom || (this.tweenUp)?-this._dropdown.height:this._dropdown.height;
               this._showingDropdown=param1;
               _loc4_=0;
               _loc6_=getStyle("closeDuration");
               _loc7_=getStyle("closeEasingFunction") as Function;
               this._dropdown.resetDragScrolling();
            }
         }
         this.inTween=true;
         if((param3) || (param1))
         {
            UIComponentGlobals.layoutManager.validateNow();
         }
         UIComponent.suspendBackgroundProcessing();
         if(this._dropdown)
         {
            this._dropdown.enabled=false;
         }
         _loc6_=Math.max(1,_loc6_);
         if(!param3)
         {
            _loc6_=1;
         }
         this.tween=new Tween(this,_loc4_,_loc5_,_loc6_);
         this.triggerEvent=param2;
         return;
      }

      private function dispatchChangeEvent(param1:Event, param2:int, param3:int) : void {
         var _loc4_:Event = null;
         if(param2 != param3)
         {
            _loc4_=param1  is  ListEvent?param1:new ListEvent("change");
            dispatchEvent(_loc4_);
         }
         return;
      }

      private function destroyDropdown() : void {
         if(this.inTween)
         {
            this.tween.endTween();
         }
         this.displayDropdown(false,null,false);
         return;
      }

      private var implicitSelectedIndex:Boolean = false;

      override protected function collectionChangeHandler(param1:Event) : void {
         var _loc3_:CollectionEvent = null;
         var _loc2_:int = selectedIndex;
         super.collectionChangeHandler(param1);
         if(param1  is  CollectionEvent)
         {
            _loc3_=CollectionEvent(param1);
            if(collection.length == 0)
            {
               if(!selectedIndexChanged && !selectedItemChanged)
               {
                  if(super.selectedIndex != -1)
                  {
                     super.selectedIndex=-1;
                  }
                  this.implicitSelectedIndex=true;
                  invalidateDisplayList();
               }
               if((textInput) && !editable)
               {
                  textInput.text="";
               }
            }
            else
            {
               if(_loc3_.kind == CollectionEventKind.ADD)
               {
                  if(collection.length == _loc3_.items.length)
                  {
                     if(selectedIndex == -1 && this._prompt == null)
                     {
                        this.selectedIndex=0;
                     }
                  }
                  else
                  {
                     return;
                  }
               }
               else
               {
                  if(_loc3_.kind == CollectionEventKind.UPDATE)
                  {
                     if(_loc3_.location == selectedIndex || _loc3_.items[0].source == selectedItem)
                     {
                        selectionChanged=true;
                     }
                  }
                  else
                  {
                     if(_loc3_.kind == CollectionEventKind.REPLACE)
                     {
                        return;
                     }
                     if(_loc3_.kind == CollectionEventKind.RESET)
                     {
                        this.collectionChanged=true;
                        if(!selectedIndexChanged && !selectedItemChanged)
                        {
                           this.selectedIndex=this.prompt?-1:0;
                        }
                        invalidateProperties();
                     }
                  }
               }
            }
            invalidateDisplayList();
            this.destroyDropdown();
         }
         return;
      }

      override protected function textInput_changeHandler(param1:Event) : void {
         super.textInput_changeHandler(param1);
         this.dispatchChangeEvent(param1,-1,-2);
         return;
      }

      override protected function downArrowButton_buttonDownHandler(param1:FlexEvent) : void {
         if(this._showingDropdown)
         {
            this.close(param1);
         }
         else
         {
            this.displayDropdown(true,param1);
         }
         return;
      }

      private function dropdown_mouseOutsideHandler(param1:Event) : void {
         var _loc2_:MouseEvent = null;
         if(param1  is  MouseEvent)
         {
            _loc2_=MouseEvent(param1);
            if(_loc2_.target != this._dropdown)
            {
               return;
            }
            if(!hitTestPoint(_loc2_.stageX,_loc2_.stageY,true))
            {
               this.close(param1);
            }
         }
         else
         {
            if(param1  is  SandboxMouseEvent)
            {
               this.close(param1);
            }
         }
         return;
      }

      private function dropdown_itemClickHandler(param1:ListEvent) : void {
         if(this._showingDropdown)
         {
            this.close();
         }
         return;
      }

      override protected function focusOutHandler(param1:FocusEvent) : void {
         if((this._showingDropdown) && (this._dropdown) && (this.contains(DisplayObject(param1.target))))
         {
            if(!param1.relatedObject || !this._dropdown.contains(param1.relatedObject))
            {
               this.close();
            }
         }
         super.focusOutHandler(param1);
         return;
      }

      private function stage_resizeHandler(param1:Event) : void {
         this.destroyDropdown();
         return;
      }

      private function dropdown_scrollHandler(param1:Event) : void {
         var _loc2_:ScrollEvent = null;
         if(param1  is  ScrollEvent)
         {
            _loc2_=ScrollEvent(param1);
            if(_loc2_.detail == ScrollEventDetail.THUMB_TRACK || _loc2_.detail == ScrollEventDetail.THUMB_POSITION || _loc2_.detail == ScrollEventDetail.LINE_UP || _loc2_.detail == ScrollEventDetail.LINE_DOWN)
            {
               dispatchEvent(_loc2_);
            }
         }
         return;
      }

      private function dropdown_itemRollOverHandler(param1:Event) : void {
         dispatchEvent(param1);
         return;
      }

      private function dropdown_itemRollOutHandler(param1:Event) : void {
         dispatchEvent(param1);
         return;
      }

      private function dropdown_changeHandler(param1:Event) : void {
         var _loc2_:int = selectedIndex;
         if(this._dropdown)
         {
            this.selectedIndex=this._dropdown.selectedIndex;
         }
         if(!this._showingDropdown)
         {
            this.dispatchChangeEvent(param1,_loc2_,selectedIndex);
         }
         else
         {
            if(!this.bInKeyDown)
            {
               this.close();
            }
         }
         return;
      }

      override protected function keyDownHandler(param1:KeyboardEvent) : void {
         var _loc2_:* = 0;
         if(!enabled)
         {
            return;
         }
         if(param1.target == textInput)
         {
            return;
         }
         if((param1.ctrlKey) && param1.keyCode == Keyboard.DOWN)
         {
            this.displayDropdown(true,param1);
            param1.stopPropagation();
         }
         else
         {
            if((param1.ctrlKey) && param1.keyCode == Keyboard.UP)
            {
               this.close(param1);
               param1.stopPropagation();
            }
            else
            {
               if(param1.keyCode == Keyboard.ESCAPE)
               {
                  if(this._showingDropdown)
                  {
                     if(this._oldIndex != this._dropdown.selectedIndex)
                     {
                        this.selectedIndex=this._oldIndex;
                     }
                     this.displayDropdown(false);
                     param1.stopPropagation();
                  }
               }
               else
               {
                  if(param1.keyCode == Keyboard.ENTER)
                  {
                     if(this._showingDropdown)
                     {
                        this.close();
                        param1.stopPropagation();
                     }
                  }
                  else
                  {
                     if(!editable || param1.keyCode == Keyboard.UP || param1.keyCode == Keyboard.DOWN || param1.keyCode == Keyboard.PAGE_UP || param1.keyCode == Keyboard.PAGE_DOWN)
                     {
                        _loc2_=selectedIndex;
                        this.bInKeyDown=this._showingDropdown;
                        this.dropdown.dispatchEvent(param1.clone());
                        param1.stopPropagation();
                        this.bInKeyDown=false;
                     }
                  }
               }
            }
         }
         return;
      }

      private function unloadHandler(param1:Event) : void {
         if(this.inTween)
         {
            UIComponent.resumeBackgroundProcessing();
            this.inTween=false;
         }
         if(this._dropdown)
         {
            this._dropdown.parent.removeChild(this._dropdown);
         }
         return;
      }

      private function removedFromStageHandler(param1:Event) : void {
         this.destroyDropdown();
         return;
      }

      mx_internal function onTweenUpdate(param1:Number) : void {
         if(this._dropdown)
         {
            this._dropdown.scrollRect=new Rectangle(0,param1,this._dropdown.width,this._dropdown.height);
         }
         return;
      }

      mx_internal function onTweenEnd(param1:Number) : void {
         if(this._dropdown)
         {
            this._dropdown.scrollRect=null;
            this.inTween=false;
            this._dropdown.enabled=true;
            this._dropdown.visible=this._showingDropdown;
            if(this.bRemoveDropdown)
            {
               this._dropdown.removeEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE,this.dropdown_mouseOutsideHandler);
               this._dropdown.removeEventListener(FlexMouseEvent.MOUSE_WHEEL_OUTSIDE,this.dropdown_mouseOutsideHandler);
               this._dropdown.removeEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE,this.dropdown_mouseOutsideHandler);
               this._dropdown.removeEventListener(SandboxMouseEvent.MOUSE_WHEEL_SOMEWHERE,this.dropdown_mouseOutsideHandler);
               PopUpManager.removePopUp(this._dropdown);
               this._dropdown=null;
            }
         }
         this.bRemoveDropdown=true;
         UIComponent.resumeBackgroundProcessing();
         var _loc2_:DropdownEvent = new DropdownEvent(this._showingDropdown?DropdownEvent.OPEN:DropdownEvent.CLOSE);
         _loc2_.triggerEvent=this.triggerEvent;
         dispatchEvent(_loc2_);
         return;
      }

      override protected function calculatePreferredSizeFromData(param1:int) : Object {
         var _loc6_:TextLineMetrics = null;
         var _loc8_:Object = null;
         var _loc9_:String = null;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:CursorBookmark = iterator?iterator.bookmark:null;
         iterator.seek(CursorBookmark.FIRST,0);
         var _loc5_:* = !(iterator == null);
         var _loc7_:* = 0;
         while(_loc7_ < param1)
         {
            if(_loc5_)
            {
               _loc8_=iterator?iterator.current:null;
            }
            else
            {
               _loc8_=null;
            }
            _loc9_=this.itemToLabel(_loc8_);
            _loc6_=measureText(_loc9_);
            _loc2_=Math.max(_loc2_,_loc6_.width);
            _loc3_=Math.max(_loc3_,_loc6_.height);
            if(iterator)
            {
               iterator.moveNext();
            }
            _loc7_++;
         }
         if(this.prompt)
         {
            _loc6_=measureText(this.prompt);
            _loc2_=Math.max(_loc2_,_loc6_.width);
            _loc3_=Math.max(_loc3_,_loc6_.height);
         }
         _loc2_=_loc2_ + (getStyle("paddingLeft") + getStyle("paddingRight"));
         if(iterator)
         {
            iterator.seek(_loc4_,0);
         }
         return {
         "width":_loc2_,
         "height":_loc3_
         }
         ;
      }

      mx_internal function get isShowingDropdown() : Boolean {
         return this._showingDropdown;
      }
   }

}