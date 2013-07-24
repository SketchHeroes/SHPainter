package mx.controls
{
   import mx.controls.listClasses.ListBase;
   import mx.core.IIMESupport;
   import mx.core.mx_internal;
   import mx.controls.listClasses.IListItemRenderer;
   import flash.utils.Dictionary;
   import mx.core.IFactory;
   import mx.events.ListEventReason;
   import mx.core.EdgeMetrics;
   import mx.collections.CursorBookmark;
   import mx.collections.errors.ItemPendingError;
   import mx.controls.listClasses.ListBaseSeekPending;
   import mx.collections.ItemResponder;
   import mx.core.ScrollPolicy;
   import flash.display.Sprite;
   import mx.core.FlexSprite;
   import flash.display.Shape;
   import mx.core.FlexShape;
   import flash.display.Graphics;
   import flash.geom.Point;
   import mx.controls.listClasses.BaseListData;
   import mx.controls.listClasses.ListRowInfo;
   import mx.collections.ItemWrapper;
   import flash.display.DisplayObject;
   import mx.controls.listClasses.IDropInListItemRenderer;
   import mx.core.IInvalidating;
   import mx.core.UIComponentGlobals;
   import mx.collections.ModifiedCollectionView;
   import flash.events.Event;
   import mx.controls.scrollClasses.ScrollBar;
   import mx.events.ScrollEvent;
   import mx.events.ScrollEventDetail;
   import mx.controls.listClasses.ListData;
   import flash.events.MouseEvent;
   import mx.managers.IFocusManagerComponent;
   import mx.events.ListEvent;
   import mx.core.ClassFactory;
   import flash.events.KeyboardEvent;
   import mx.events.SandboxMouseEvent;
   import mx.core.UIComponent;
   import flash.events.FocusEvent;
   import flash.ui.Keyboard;
   import mx.managers.IFocusManager;
   import mx.collections.IList;
   import mx.core.IPropertyChangeNotifier;
   import mx.events.CollectionEvent;
   import mx.events.CollectionEventKind;
   import mx.controls.listClasses.ListItemRenderer;
   import mx.core.EventPriority;

   use namespace mx_internal;

   public class List extends ListBase implements IIMESupport
   {
      public function List() {
         super();
         listType="vertical";
         bColumnScrolling=false;
         this.itemRenderer=new ClassFactory(ListItemRenderer);
         _horizontalScrollPolicy=ScrollPolicy.OFF;
         _verticalScrollPolicy=ScrollPolicy.AUTO;
         defaultColumnCount=1;
         defaultRowCount=7;
         addEventListener(ListEvent.ITEM_EDIT_BEGINNING,this.itemEditorItemEditBeginningHandler,false,EventPriority.DEFAULT_HANDLER);
         addEventListener(ListEvent.ITEM_EDIT_BEGIN,this.itemEditorItemEditBeginHandler,false,EventPriority.DEFAULT_HANDLER);
         addEventListener(ListEvent.ITEM_EDIT_END,this.itemEditorItemEditEndHandler,false,EventPriority.DEFAULT_HANDLER);
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      mx_internal  static var createAccessibilityImplementation:Function;

      public var itemEditorInstance:IListItemRenderer;

      public function get editedItemRenderer() : IListItemRenderer {
         if(!this.itemEditorInstance)
         {
            return null;
         }
         return listItems[this.actualRowIndex][this.actualColIndex];
      }

      private var dontEdit:Boolean = false;

      private var losingFocus:Boolean = false;

      private var inEndEdit:Boolean = false;

      private var actualRowIndex:int;

      private var actualColIndex:int = 0;

      protected var measuringObjects:Dictionary;

      override public function set maxHorizontalScrollPosition(param1:Number) : void {
         super.maxHorizontalScrollPosition=param1;
         scrollAreaChanged=true;
         invalidateDisplayList();
         return;
      }

      private var _editable:Boolean = false;

      public function get editable() : Boolean {
         return this._editable;
      }

      public function set editable(param1:Boolean) : void {
         this._editable=param1;
         return;
      }

      public var itemEditor:IFactory;

      public var editorDataField:String = "text";

      public var editorHeightOffset:Number = 0;

      public var editorWidthOffset:Number = 0;

      public var editorXOffset:Number = 0;

      public var editorYOffset:Number = 0;

      public var editorUsesEnterKey:Boolean = false;

      override public function set enabled(param1:Boolean) : void {
         super.enabled=param1;
         if(this.itemEditorInstance)
         {
            this.endEdit(ListEventReason.OTHER);
         }
         invalidateDisplayList();
         return;
      }

      private var bEditedItemPositionChanged:Boolean = false;

      private var _proposedEditedItemPosition;

      private var lastEditedItemPosition;

      private var _editedItemPosition:Object;

      public function get editedItemPosition() : Object {
         if(this._editedItemPosition)
         {
            return {
            "rowIndex":this._editedItemPosition.rowIndex,
            "columnIndex":0
         }
         ;
         }
         return this._editedItemPosition;
      }

      public function set editedItemPosition(param1:Object) : void {
         var _loc2_:Object = 
            {
               "rowIndex":param1.rowIndex,
               "columnIndex":0
            }
         ;
         this.setEditedItemPosition(_loc2_);
         return;
      }

      public function get enableIME() : Boolean {
         return false;
      }

      mx_internal var _lockedRowCount:int = 0;

      public function get lockedRowCount() : int {
         return this._lockedRowCount;
      }

      public function set lockedRowCount(param1:int) : void {
         this._lockedRowCount=param1;
         invalidateDisplayList();
         return;
      }

      public var rendererIsEditor:Boolean = false;

      private var _imeMode:String;

      public function get imeMode() : String {
         return this._imeMode;
      }

      public function set imeMode(param1:String) : void {
         this._imeMode=param1;
         return;
      }

      override public function set dataProvider(param1:Object) : void {
         if(this.itemEditorInstance)
         {
            this.endEdit(ListEventReason.OTHER);
         }
         super.dataProvider=param1;
         return;
      }

      override protected function initializeAccessibility() : void {
         if(createAccessibilityImplementation != null)
         {
            createAccessibilityImplementation(this);
         }
         return;
      }

      override protected function commitProperties() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         var _loc3_:IListItemRenderer = null;
         var _loc4_:* = NaN;
         var _loc5_:* = 0;
         super.commitProperties();
         if(itemsNeedMeasurement)
         {
            itemsNeedMeasurement=false;
            if(isNaN(explicitRowHeight))
            {
               if(iterator)
               {
                  _loc1_=getStyle("paddingTop");
                  _loc2_=getStyle("paddingBottom");
                  _loc3_=this.getMeasuringRenderer(iterator.current);
                  _loc4_=200;
                  if(listContent.width)
                  {
                     _loc4_=listContent.width;
                  }
                  _loc3_.explicitWidth=_loc4_;
                  this.setupRendererFromData(_loc3_,iterator.current);
                  _loc5_=_loc3_.getExplicitOrMeasuredHeight() + _loc1_ + _loc2_;
                  setRowHeight(Math.max(_loc5_,20));
               }
               else
               {
                  setRowHeight(20);
               }
            }
            if(isNaN(explicitColumnWidth))
            {
               setColumnWidth(this.measureWidthOfItems(0,explicitRowCount < 1?defaultRowCount:explicitRowCount));
            }
         }
         return;
      }

      override protected function measure() : void {
         super.measure();
         var _loc1_:EdgeMetrics = viewMetrics;
         measuredMinWidth=DEFAULT_MEASURED_MIN_WIDTH;
         if((initialized) && (variableRowHeight) && explicitRowCount < 1 && (isNaN(explicitRowHeight)))
         {
            measuredHeight=height;
         }
         return;
      }

      override protected function configureScrollBars() : void {
         var _loc2_:* = NaN;
         var _loc3_:* = 0;
         var _loc13_:CursorBookmark = null;
         var _loc14_:* = 0;
         var _loc1_:int = listItems.length;
         if(_loc1_ == 0)
         {
            return;
         }
         var _loc4_:int = listItems.length;
         while(_loc1_ > 1 && rowInfo[_loc4_-1].y + rowInfo[_loc4_-1].height > listContent.height - listContent.bottomOffset)
         {
            _loc1_--;
            _loc4_--;
         }
         var _loc5_:int = verticalScrollPosition - this.lockedRowCount-1;
         var _loc6_:* = 0;
         while((_loc1_) && listItems[_loc1_-1].length == 0)
         {
            if((collection) && _loc1_ + _loc5_ >= collection.length)
            {
               _loc1_--;
               _loc6_++;
               continue;
            }
            break;
         }
         if(verticalScrollPosition > 0 && _loc6_ > 0 && !runningDataEffect)
         {
            _loc13_=iterator.bookmark;
            _loc14_=_loc13_.getViewIndex();
            if(verticalScrollPosition != _loc14_ - this.lockedRowCount)
            {
               super.verticalScrollPosition=Math.max(_loc14_ - this.lockedRowCount,0);
            }
            if(this.adjustVerticalScrollPositionDownward(Math.max(_loc1_,1)))
            {
               return;
            }
         }
         if(listContent.topOffset)
         {
            _loc2_=Math.abs(listContent.topOffset);
            _loc3_=0;
            while(rowInfo[_loc3_].y + rowInfo[_loc3_].height <= _loc2_)
            {
               _loc1_--;
               _loc3_++;
               if(_loc3_ == _loc1_)
               {
                  break;
               }
            }
         }
         var _loc7_:int = listItems[0].length;
         var _loc8_:Object = horizontalScrollBar;
         var _loc9_:Object = verticalScrollBar;
         var _loc10_:int = Math.round(unscaledWidth);
         var _loc11_:int = collection?collection.length - this.lockedRowCount:0;
         var _loc12_:int = _loc1_ - this.lockedRowCount;
         setScrollBarProperties(isNaN(_maxHorizontalScrollPosition)?Math.round(listContent.width):Math.round(_maxHorizontalScrollPosition + _loc10_),_loc10_,_loc11_,_loc12_);
         maxVerticalScrollPosition=Math.max(_loc11_ - _loc12_,0);
         return;
      }

      private function adjustVerticalScrollPositionDownward(param1:int) : Boolean {
         var n:int = 0;
         var j:int = 0;
         var more:Boolean = false;
         var data:Object = null;
         var rowCount:int = param1;
         var bookmark:CursorBookmark = iterator.bookmark;
         var h:Number = 0;
         var ch:Number = 0;
         var paddingTop:Number = getStyle("paddingTop");
         var paddingBottom:Number = getStyle("paddingBottom");
         var paddingLeft:Number = getStyle("paddingLeft");
         var paddingRight:Number = getStyle("paddingRight");
         h=rowInfo[rowCount-1].y + rowInfo[rowCount-1].height;
         h=listContent.heightExcludingOffsets - listContent.topOffset - h;
         var numRows:int = 0;
         try
         {
            if(iterator.afterLast)
            {
               iterator.seek(CursorBookmark.LAST,0);
            }
            else
            {
               more=iterator.movePrevious();
            }
         }
         catch(e:ItemPendingError)
         {
            more=false;
         }
         if(!more)
         {
            super.verticalScrollPosition=0;
            try
            {
               iterator.seek(CursorBookmark.FIRST,0);
               if(!iteratorValid)
               {
                  iteratorValid=true;
                  lastSeekPending=null;
               }
            }
            catch(e:ItemPendingError)
            {
               lastSeekPending=new ListBaseSeekPending(CursorBookmark.FIRST,0);
               e.addResponder(new ItemResponder(seekPendingResultHandler,seekPendingFailureHandler,lastSeekPending));
               iteratorValid=false;
               invalidateList();
               return true;
            }
            updateList();
            return true;
         }
         var item:IListItemRenderer = this.getMeasuringRenderer(iterator.current);
         item.explicitWidth=listContent.width - paddingLeft - paddingRight;
         while(h > 0 && (more))
         {
            if(more)
            {
               data=iterator.current;
               this.setupRendererFromData(item,data);
               ch=variableRowHeight?item.getExplicitOrMeasuredHeight() + paddingBottom + paddingTop:rowHeight;
            }
            h=h - ch;
            try
            {
               more=iterator.movePrevious();
               numRows++;
            }
            catch(e:ItemPendingError)
            {
               more=false;
               continue;
            }
         }
         if(h < 0)
         {
            numRows--;
         }
         iterator.seek(bookmark,0);
         verticalScrollPosition=Math.max(0,verticalScrollPosition - numRows);
         if(numRows > 0 && !variableRowHeight)
         {
            this.configureScrollBars();
         }
         return numRows > 0;
      }

      override protected function updateDisplayList(param1:Number, param2:Number) : void {
         super.updateDisplayList(param1,param2);
         setRowCount(listItems.length);
         if((this.bEditedItemPositionChanged) && !this.editingTemporarilyPrevented(this._proposedEditedItemPosition))
         {
            this.bEditedItemPositionChanged=false;
            this.commitEditedItemPosition(this._proposedEditedItemPosition);
            this._proposedEditedItemPosition=undefined;
         }
         this.drawRowBackgrounds();
         return;
      }

      override protected function adjustListContent(param1:Number=-1, param2:Number=-1) : void {
         var _loc3_:Number = viewMetrics.left + Math.max(listContent.leftOffset,0);
         var _loc4_:Number = viewMetrics.top + listContent.topOffset;
         listContent.move(_loc3_,_loc4_);
         var _loc5_:Number = Math.max(0,listContent.rightOffset) - _loc3_ - viewMetrics.right;
         var _loc6_:Number = Math.max(0,listContent.bottomOffset) - _loc4_ - viewMetrics.bottom;
         var _loc7_:Number = param1 + _loc5_;
         if(horizontalScrollPolicy == ScrollPolicy.ON || horizontalScrollPolicy == ScrollPolicy.AUTO && !isNaN(_maxHorizontalScrollPosition))
         {
            if(isNaN(_maxHorizontalScrollPosition))
            {
               _loc7_=_loc7_ * 2;
            }
            else
            {
               _loc7_=_loc7_ + _maxHorizontalScrollPosition;
            }
         }
         listContent.setActualSize(_loc7_,param2 + _loc6_);
         return;
      }

      override protected function drawRowBackgrounds() : void {
         var _loc2_:Array = null;
         var _loc7_:* = 0;
         var _loc1_:Sprite = Sprite(listContent.getChildByName("rowBGs"));
         if(!_loc1_)
         {
            _loc1_=new FlexSprite();
            _loc1_.mouseEnabled=false;
            _loc1_.name="rowBGs";
            listContent.addChildAt(_loc1_,0);
         }
         var _loc3_:Object = getStyle("alternatingItemColors");
         if(_loc3_)
         {
            _loc2_=_loc3_  is  Array?_loc3_ as Array:[_loc3_];
         }
         while(_loc1_.numChildren > _loc7_)
         {
            _loc1_.removeChildAt(_loc1_.numChildren-1);
         }
         return;
      }

      protected function drawRowBackground(param1:Sprite, param2:int, param3:Number, param4:Number, param5:uint, param6:int) : void {
         var _loc7_:Shape = null;
         if(param2 < param1.numChildren)
         {
            _loc7_=Shape(param1.getChildAt(param2));
         }
         else
         {
            _loc7_=new FlexShape();
            _loc7_.name="rowBackground";
            param1.addChild(_loc7_);
         }
         var param4:Number = Math.min(rowInfo[param2].height,listContent.height - rowInfo[param2].y);
         _loc7_.y=rowInfo[param2].y;
         var _loc8_:Graphics = _loc7_.graphics;
         _loc8_.clear();
         _loc8_.beginFill(param5,getStyle("backgroundAlpha"));
         _loc8_.drawRect(0,0,listContent.width,param4);
         _loc8_.endFill();
         return;
      }

      override protected function makeRowsAndColumns(param1:Number, param2:Number, param3:Number, param4:Number, param5:int, param6:int, param7:Boolean=false, param8:uint=0) : Point {
         var yy:Number = NaN;
         var hh:Number = NaN;
         var i:int = 0;
         var j:int = 0;
         var item:IListItemRenderer = null;
         var oldItem:IListItemRenderer = null;
         var rowData:BaseListData = null;
         var data:Object = null;
         var wrappedData:Object = null;
         var uid:String = null;
         var rh:Number = NaN;
         var ld:BaseListData = null;
         var rr:Array = null;
         var rowInfo:ListRowInfo = null;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var dw:Number = NaN;
         var dh:Number = NaN;
         var left:Number = param1;
         var top:Number = param2;
         var right:Number = param3;
         var bottom:Number = param4;
         var firstCol:int = param5;
         var firstRow:int = param6;
         var byCount:Boolean = param7;
         var rowsNeeded:uint = param8;
         listContent.allowItemSizeChangeNotification=false;
         var paddingLeft:Number = getStyle("paddingLeft");
         var paddingRight:Number = getStyle("paddingRight");
         var xx:Number = left + paddingLeft - horizontalScrollPosition;
         var ww:Number = right - paddingLeft - paddingRight;
         var bSelected:Boolean = false;
         var bHighlight:Boolean = false;
         var bCaret:Boolean = false;
         var colNum:int = 0;
         var rowNum:int = this.lockedRowCount;
         var rowsMade:int = 0;
         var more:Boolean = true;
         var valid:Boolean = true;
         yy=top;
         rowNum=firstRow;
         more=!(iterator == null) && !iterator.afterLast && (iteratorValid);
         while(!byCount && yy < bottom || (byCount) && rowsNeeded > 0)
         {
            if(byCount)
            {
               rowsNeeded--;
            }
            valid=more;
            wrappedData=more?iterator.current:null;
            data=wrappedData  is  ItemWrapper?wrappedData.data:wrappedData;
            uid=null;
            if(!listItems[rowNum])
            {
               listItems[rowNum]=[];
            }
            if(valid)
            {
               item=listItems[rowNum][colNum];
               uid=itemToUID(wrappedData);
               if(!item || ((runningDataEffect) && (dataItemWrappersByRenderer[item])?!(dataItemWrappersByRenderer[item] == wrappedData):!(item.data == data)))
               {
                  if(allowRendererStealingDuringLayout)
                  {
                     item=visibleData[uid];
                     if(!item && !(wrappedData == data))
                     {
                        item=visibleData[itemToUID(data)];
                     }
                  }
                  if(item)
                  {
                     ld=BaseListData(rowMap[item.name]);
                     if((ld) && ld.rowIndex > rowNum)
                     {
                        listItems[ld.rowIndex]=[];
                     }
                     else
                     {
                        item=null;
                     }
                  }
                  if(!item)
                  {
                     item=getReservedOrFreeItemRenderer(wrappedData);
                  }
                  if(!item)
                  {
                     item=this.createItemRenderer(data);
                     item.owner=this;
                     item.styleName=listContent;
                     listContent.addChild(DisplayObject(item));
                  }
                  oldItem=listItems[rowNum][colNum];
                  if(oldItem)
                  {
                     addToFreeItemRenderers(oldItem);
                  }
                  listItems[rowNum][colNum]=item;
               }
               rowData=this.makeListData(data,uid,rowNum);
               rowMap[item.name]=rowData;
               if(item  is  IDropInListItemRenderer)
               {
                  if(data != null)
                  {
                     IDropInListItemRenderer(item).listData=rowData;
                  }
                  else
                  {
                     IDropInListItemRenderer(item).listData=null;
                  }
               }
               item.data=data;
               item.enabled=enabled;
               item.visible=true;
               if(uid != null)
               {
                  visibleData[uid]=item;
               }
               if(wrappedData != data)
               {
                  dataItemWrappersByRenderer[item]=wrappedData;
               }
               item.explicitWidth=ww;
               if(item  is  IInvalidating && ((wordWrapChanged) || (variableRowHeight)))
               {
                  IInvalidating(item).invalidateSize();
               }
               UIComponentGlobals.layoutManager.validateClient(item,true);
               hh=Math.ceil(variableRowHeight?item.getExplicitOrMeasuredHeight() + cachedPaddingTop + cachedPaddingBottom:rowHeight);
               rh=item.getExplicitOrMeasuredHeight();
               item.setActualSize(ww,variableRowHeight?rh:rowHeight - cachedPaddingTop - cachedPaddingBottom);
               item.move(xx,yy + cachedPaddingTop);
            }
            else
            {
               hh=rowNum > 0?rowInfo[rowNum-1].height:rowHeight;
               if(hh == 0)
               {
                  hh=rowHeight;
               }
               oldItem=listItems[rowNum][colNum];
               if(oldItem)
               {
                  addToFreeItemRenderers(oldItem);
                  listItems[rowNum].splice(colNum,1);
               }
            }
            bSelected=!(selectedData[uid] == null);
            if(wrappedData != data)
            {
               bSelected=(bSelected) || (selectedData[itemToUID(data)]);
               bSelected=(bSelected) && !getRendererSemanticValue(item,ModifiedCollectionView.REPLACEMENT) && !getRendererSemanticValue(item,ModifiedCollectionView.ADDED);
            }
            bHighlight=highlightUID == uid;
            bCaret=caretUID == uid;
            rowInfo[rowNum]=new ListRowInfo(yy,hh,uid,data);
            if(valid)
            {
               drawItem(item,bSelected,bHighlight,bCaret);
            }
            yy=yy + hh;
            rowNum++;
            rowsMade++;
            if((iterator) && (more))
            {
               try
               {
                  more=iterator.moveNext();
               }
               catch(e:ItemPendingError)
               {
                  lastSeekPending=new ListBaseSeekPending(CursorBookmark.CURRENT,0);
                  e.addResponder(new ItemResponder(seekPendingResultHandler,seekPendingFailureHandler,lastSeekPending));
                  more=false;
                  iteratorValid=false;
                  continue;
               }
            }
         }
         if(!byCount)
         {
            while(rowNum < listItems.length)
            {
               rr=listItems.pop();
               rowInfo.pop();
               while(rr.length)
               {
                  item=rr.pop();
                  addToFreeItemRenderers(item);
               }
            }
         }
         if(this.itemEditorInstance)
         {
            listContent.setChildIndex(DisplayObject(this.itemEditorInstance),listContent.numChildren-1);
            item=listItems[this.actualRowIndex][this.actualColIndex];
            rowInfo=rowInfo[this.actualRowIndex];
            if((item) && !this.rendererIsEditor)
            {
               dx=this.editorXOffset;
               dy=this.editorYOffset;
               dw=this.editorWidthOffset;
               dh=this.editorHeightOffset;
               this.layoutEditor(item.x + dx,rowInfo.y + dy,Math.min(item.width + dw,listContent.width - listContent.x - this.itemEditorInstance.x),Math.min(rowInfo.height + dh,listContent.height - listContent.y - this.itemEditorInstance.y));
            }
         }
         listContent.allowItemSizeChangeNotification=variableRowHeight;
         return new Point(colNum,rowsMade);
      }

      protected function layoutEditor(param1:int, param2:int, param3:int, param4:int) : void {
         this.itemEditorInstance.move(param1,param2);
         this.itemEditorInstance.setActualSize(param3,param4);
         return;
      }

      override protected function scrollHandler(param1:Event) : void {
         var scrollBar:ScrollBar = null;
         var pos:Number = NaN;
         var delta:int = 0;
         var o:EdgeMetrics = null;
         var bookmark:CursorBookmark = null;
         var event:Event = param1;
         if(event  is  ScrollEvent)
         {
            if(this.itemEditorInstance)
            {
               this.endEdit(ListEventReason.OTHER);
            }
            if(!liveScrolling && ScrollEvent(event).detail == ScrollEventDetail.THUMB_TRACK)
            {
               return;
            }
            scrollBar=ScrollBar(event.target);
            pos=scrollBar.scrollPosition;
            removeClipMask();
            if(scrollBar == verticalScrollBar)
            {
               delta=pos - verticalScrollPosition;
               super.scrollHandler(event);
               if(Math.abs(delta) >= listItems.length - this.lockedRowCount || !iteratorValid)
               {
                  try
                  {
                     if(!iteratorValid)
                     {
                        iterator.seek(CursorBookmark.FIRST,pos);
                     }
                     else
                     {
                        iterator.seek(CursorBookmark.CURRENT,delta);
                     }
                     if(!iteratorValid)
                     {
                        iteratorValid=true;
                        lastSeekPending=null;
                     }
                  }
                  catch(e:ItemPendingError)
                  {
                     lastSeekPending=new ListBaseSeekPending(CursorBookmark.FIRST,pos);
                     e.addResponder(new ItemResponder(seekPendingResultHandler,seekPendingFailureHandler,lastSeekPending));
                     iteratorValid=false;
                  }
                  bookmark=iterator.bookmark;
                  clearIndicators();
                  clearVisibleData();
                  this.makeRowsAndColumns(0,0,listContent.width,listContent.height,0,0);
                  iterator.seek(bookmark,0);
               }
               else
               {
                  if(delta != 0)
                  {
                     scrollVertically(pos,Math.abs(delta),Boolean(delta > 0));
                  }
               }
               if(variableRowHeight)
               {
                  this.configureScrollBars();
               }
               this.drawRowBackgrounds();
            }
            else
            {
               delta=pos - _horizontalScrollPosition;
               super.scrollHandler(event);
               this.scrollHorizontally(pos,Math.abs(delta),Boolean(delta > 0));
            }
            addClipMask(false);
         }
         return;
      }

      override protected function scrollHorizontally(param1:int, param2:int, param3:Boolean) : void {
         var _loc4_:int = listItems.length;
         var _loc5_:Number = getStyle("paddingLeft");
         var _loc6_:* = 0;
         while(_loc6_ < _loc4_)
         {
            if(listItems[_loc6_].length)
            {
               listItems[_loc6_][0].x=-param1 + _loc5_;
            }
            _loc6_++;
         }
         return;
      }

      protected function makeListData(param1:Object, param2:String, param3:int) : BaseListData {
         return new ListData(itemToLabel(param1),itemToIcon(param1),labelField,param2,this,param3);
      }

      mx_internal function setupRendererFromData(param1:IListItemRenderer, param2:Object) : void {
         var _loc3_:Object = param2  is  ItemWrapper?param2.data:param2;
         if(param1  is  IDropInListItemRenderer)
         {
            if(_loc3_ != null)
            {
               IDropInListItemRenderer(param1).listData=this.makeListData(_loc3_,itemToUID(param2),0);
            }
            else
            {
               IDropInListItemRenderer(param1).listData=null;
            }
         }
         param1.data=_loc3_;
         if(param1  is  IInvalidating)
         {
            IInvalidating(param1).invalidateSize();
         }
         UIComponentGlobals.layoutManager.validateClient(param1,true);
         return;
      }

      override public function measureWidthOfItems(param1:int=-1, param2:int=0) : Number {
         var item:IListItemRenderer = null;
         var rw:Number = NaN;
         var data:Object = null;
         var factory:IFactory = null;
         var index:int = param1;
         var count:int = param2;
         if(count == 0)
         {
            count=collection?collection.length:0;
         }
         if((collection) && collection.length == 0)
         {
            count=0;
         }
         var w:Number = 0;
         var bookmark:CursorBookmark = iterator?iterator.bookmark:null;
         if(!(index == -1) && (iterator))
         {
            try
            {
               iterator.seek(CursorBookmark.FIRST,index);
            }
            catch(e:ItemPendingError)
            {
               return 0;
            }
         }
         var more:Boolean = !(iterator == null);
         var i:int = 0;
         while(i < count)
         {
            if(more)
            {
               data=iterator.current;
               factory=getItemRendererFactory(data);
               item=this.measuringObjects[factory];
               if(!item)
               {
                  item=this.getMeasuringRenderer(data);
               }
               item.explicitWidth=NaN;
               this.setupRendererFromData(item,data);
               rw=item.measuredWidth;
               w=Math.max(w,rw);
            }
            if(more)
            {
               try
               {
                  more=iterator.moveNext();
               }
               catch(e:ItemPendingError)
               {
                  more=false;
               }
            }
            i++;
         }
         if(iterator)
         {
            iterator.seek(bookmark,0);
         }
         if(w == 0)
         {
            if(explicitWidth)
            {
               return explicitWidth;
            }
            return DEFAULT_MEASURED_WIDTH;
         }
         var paddingLeft:Number = getStyle("paddingLeft");
         var paddingRight:Number = getStyle("paddingRight");
         w=w + (paddingLeft + paddingRight);
         return w;
      }

      override public function measureHeightOfItems(param1:int=-1, param2:int=0) : Number {
         var data:Object = null;
         var item:IListItemRenderer = null;
         var index:int = param1;
         var count:int = param2;
         if(count == 0)
         {
            count=collection?collection.length:0;
         }
         var paddingTop:Number = getStyle("paddingTop");
         var paddingBottom:Number = getStyle("paddingBottom");
         var ww:Number = 200;
         if(listContent.width)
         {
            ww=listContent.width;
         }
         var h:Number = 0;
         var bookmark:CursorBookmark = iterator?iterator.bookmark:null;
         if(!(index == -1) && (iterator))
         {
            iterator.seek(CursorBookmark.FIRST,index);
         }
         var rh:Number = rowHeight;
         var more:Boolean = !(iterator == null);
         var i:int = 0;
         while(i < count)
         {
            if(more)
            {
               rh=rowHeight;
               data=iterator.current;
               item=this.getMeasuringRenderer(data);
               item.explicitWidth=ww;
               this.setupRendererFromData(item,data);
               if(variableRowHeight)
               {
                  rh=item.getExplicitOrMeasuredHeight() + paddingTop + paddingBottom;
               }
            }
            h=h + rh;
            if(more)
            {
               try
               {
                  more=iterator.moveNext();
               }
               catch(e:ItemPendingError)
               {
                  more=false;
               }
            }
            i++;
         }
         if(iterator)
         {
            iterator.seek(bookmark,0);
         }
         return h;
      }

      override protected function mouseEventToItemRenderer(param1:MouseEvent) : IListItemRenderer {
         var _loc2_:IListItemRenderer = super.mouseEventToItemRenderer(param1);
         return _loc2_ == this.itemEditorInstance?null:_loc2_;
      }

      mx_internal function getMeasuringRenderer(param1:Object) : IListItemRenderer {
         var _loc2_:IListItemRenderer = null;
         if(!this.measuringObjects)
         {
            this.measuringObjects=new Dictionary(true);
         }
         var _loc3_:IFactory = getItemRendererFactory(param1);
         _loc2_=this.measuringObjects[_loc3_];
         if(!_loc2_)
         {
            _loc2_=this.createItemRenderer(param1);
            _loc2_.owner=this;
            _loc2_.name="hiddenItem";
            _loc2_.visible=false;
            _loc2_.styleName=listContent;
            listContent.addChild(DisplayObject(_loc2_));
            this.measuringObjects[_loc3_]=_loc2_;
         }
         return _loc2_;
      }

      mx_internal function purgeMeasuringRenderers() : void {
         var _loc1_:IListItemRenderer = null;
         for each (_loc1_ in this.measuringObjects)
         {
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(DisplayObject(_loc1_));
            }
         }
         if(!this.measuringObjects)
         {
            this.measuringObjects=new Dictionary(true);
         }
         return;
      }

      override public function set itemRenderer(param1:IFactory) : void {
         super.itemRenderer=param1;
         this.purgeMeasuringRenderers();
         return;
      }

      override public function createItemRenderer(param1:Object) : IListItemRenderer {
         var _loc2_:IFactory = null;
         var _loc3_:IListItemRenderer = null;
         var _loc4_:Dictionary = null;
         var _loc5_:* = undefined;
         _loc2_=getItemRendererFactory(param1);
         if(!_loc2_)
         {
            if(param1 == null)
            {
               _loc2_=nullItemRenderer;
            }
            if(!_loc2_)
            {
               _loc2_=itemRenderer;
            }
         }
         if(_loc2_ == itemRenderer)
         {
            if((freeItemRenderers) && (freeItemRenderers.length))
            {
               _loc3_=freeItemRenderers.pop();
               delete freeItemRenderersByFactory[_loc2_][[_loc3_]];
            }
         }
         else
         {
            if(freeItemRenderersByFactory)
            {
               _loc4_=freeItemRenderersByFactory[_loc2_];
               if(_loc4_)
               {
                  for (_loc5_ in _loc4_)
                  {
                     _loc3_=IListItemRenderer(_loc5_);
                     delete _loc4_[[_loc5_]];
                  }
               }
            }
         }
         _loc3_=_loc2_.newInstance();
         _loc3_.styleName=this;
         factoryMap[_loc3_]=_loc2_;
         _loc3_.owner=this;
         return _loc3_;
      }

      private function editingTemporarilyPrevented(param1:Object) : Boolean {
         var _loc2_:* = 0;
         var _loc3_:IListItemRenderer = null;
         if((runningDataEffect) && (param1))
         {
            _loc2_=param1.rowIndex - verticalScrollPosition + offscreenExtraRowsTop;
            if(_loc2_ < 0 || _loc2_ >= listItems.length)
            {
               return false;
            }
            _loc3_=listItems[_loc2_][0];
            if((_loc3_) && ((getRendererSemanticValue(_loc3_,"replaced")) || (getRendererSemanticValue(_loc3_,"removed"))))
            {
               return true;
            }
         }
         return false;
      }

      private function setEditedItemPosition(param1:Object) : void {
         this.bEditedItemPositionChanged=true;
         this._proposedEditedItemPosition=param1;
         invalidateDisplayList();
         return;
      }

      private function commitEditedItemPosition(param1:Object) : void {
         var _loc10_:String = null;
         if(!enabled || !this.editable)
         {
            return;
         }
         if(((this.itemEditorInstance) && (param1)) && (this.itemEditorInstance  is  IFocusManagerComponent) && this._editedItemPosition.rowIndex == param1.rowIndex)
         {
            IFocusManagerComponent(this.itemEditorInstance).setFocus();
            return;
         }
         if(this.itemEditorInstance)
         {
            if(!param1)
            {
               _loc10_=ListEventReason.OTHER;
            }
            else
            {
               _loc10_=ListEventReason.NEW_ROW;
            }
            if(!this.endEdit(_loc10_) && !(_loc10_ == ListEventReason.OTHER))
            {
               return;
            }
         }
         this._editedItemPosition=param1;
         if(!param1 || (this.dontEdit))
         {
            return;
         }
         var _loc2_:int = param1.rowIndex;
         var _loc3_:int = param1.columnIndex;
         if(selectedIndex != param1.rowIndex)
         {
            commitSelectedIndex(param1.rowIndex);
         }
         var _loc4_:int = this.lockedRowCount;
         var _loc5_:int = verticalScrollPosition + listItems.length - offscreenExtraRowsTop - offscreenExtraRowsBottom-1;
         var _loc6_:int = rowInfo[listItems.length - offscreenExtraRowsBottom-1].y + rowInfo[listItems.length - offscreenExtraRowsBottom-1].height > listContent.height?1:0;
         if(_loc2_ > _loc4_)
         {
            if(_loc2_ < verticalScrollPosition + _loc4_)
            {
               verticalScrollPosition=_loc2_ - _loc4_;
            }
            else
            {
               while(_loc2_ > _loc5_ || (_loc2_ == _loc5_ && _loc2_ > verticalScrollPosition + _loc4_) && (_loc6_))
               {
                  if(verticalScrollPosition == maxVerticalScrollPosition)
                  {
                     break;
                  }
                  verticalScrollPosition=Math.min(verticalScrollPosition + (_loc2_ > _loc5_?_loc2_ - _loc5_:_loc6_),maxVerticalScrollPosition);
                  _loc5_=verticalScrollPosition + listItems.length - offscreenExtraRowsTop - offscreenExtraRowsBottom-1;
                  _loc6_=rowInfo[listItems.length - offscreenExtraRowsBottom-1].y + rowInfo[listItems.length - offscreenExtraRowsBottom-1].height > listContent.height?1:0;
               }
            }
            this.actualRowIndex=_loc2_ - verticalScrollPosition;
         }
         else
         {
            if(_loc2_ == _loc4_)
            {
               verticalScrollPosition=0;
            }
            this.actualRowIndex=_loc2_;
         }
         var _loc7_:EdgeMetrics = borderMetrics;
         this.actualColIndex=_loc3_;
         var _loc8_:IListItemRenderer = listItems[this.actualRowIndex][this.actualColIndex];
         if(!_loc8_)
         {
            this.commitEditedItemPosition(null);
            return;
         }
         if(!this.isItemEditable(_loc8_.data))
         {
            this.commitEditedItemPosition(null);
            return;
         }
         var _loc9_:ListEvent = new ListEvent(ListEvent.ITEM_EDIT_BEGIN,false,true);
         _loc9_.rowIndex=this._editedItemPosition.rowIndex;
         _loc9_.itemRenderer=_loc8_;
         dispatchEvent(_loc9_);
         this.lastEditedItemPosition=this._editedItemPosition;
         if(this.bEditedItemPositionChanged)
         {
            this.bEditedItemPositionChanged=false;
            this.commitEditedItemPosition(this._proposedEditedItemPosition);
            this._proposedEditedItemPosition=undefined;
         }
         if(!this.itemEditorInstance)
         {
            this.commitEditedItemPosition(null);
         }
         return;
      }

      public function createItemEditor(param1:int, param2:int) : void {
         var _loc5_:Class = null;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         if(!this.itemEditor)
         {
            _loc5_=getStyle("textInputClass");
            if(_loc5_)
            {
               this.itemEditor=new ClassFactory(_loc5_);
            }
            else
            {
               this.itemEditor=new ClassFactory(TextInput);
            }
         }
         var param1:* = 0;
         if(param2 > this.lockedRowCount)
         {
            param2=param2 - verticalScrollPosition;
         }
         var _loc3_:IListItemRenderer = listItems[param2][param1];
         var _loc4_:ListRowInfo = rowInfo[param2];
         if(!this.rendererIsEditor)
         {
            _loc6_=0;
            _loc7_=-2;
            _loc8_=0;
            _loc9_=4;
            if(!this.itemEditorInstance)
            {
               _loc6_=this.editorXOffset;
               _loc7_=this.editorYOffset;
               _loc8_=this.editorWidthOffset;
               _loc9_=this.editorHeightOffset;
               this.itemEditorInstance=this.itemEditor.newInstance();
               this.itemEditorInstance.owner=this;
               this.itemEditorInstance.styleName=this;
               listContent.addChild(DisplayObject(this.itemEditorInstance));
            }
            listContent.setChildIndex(DisplayObject(this.itemEditorInstance),listContent.numChildren-1);
            this.itemEditorInstance.visible=true;
            this.layoutEditor(_loc3_.x + _loc6_,_loc4_.y + _loc7_,Math.min(_loc3_.width + _loc8_,listContent.width - listContent.x - this.itemEditorInstance.x),Math.min(_loc4_.height + _loc9_,listContent.height - listContent.y - this.itemEditorInstance.y));
            DisplayObject(this.itemEditorInstance).addEventListener("focusOut",this.itemEditorFocusOutHandler);
         }
         else
         {
            this.itemEditorInstance=_loc3_;
         }
         DisplayObject(this.itemEditorInstance).addEventListener(KeyboardEvent.KEY_DOWN,this.editorKeyDownHandler);
         if(focusManager)
         {
            focusManager.defaultButtonEnabled=false;
         }
         systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_DOWN,this.editorMouseDownHandler,true,0,true);
         systemManager.getSandboxRoot().addEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE,this.editorMouseDownHandler,false,0,true);
         return;
      }

      private function findNextItemRenderer(param1:Boolean) : Boolean {
         if(!this.lastEditedItemPosition)
         {
            return false;
         }
         if(this._proposedEditedItemPosition !== undefined)
         {
            return true;
         }
         this._editedItemPosition=this.lastEditedItemPosition;
         var _loc2_:int = this._editedItemPosition.rowIndex;
         var _loc3_:int = this._editedItemPosition.columnIndex;
         var _loc4_:int = this._editedItemPosition.rowIndex + (param1?-1:1);
         if(_loc4_ < collection.length && _loc4_ >= 0)
         {
            _loc2_=_loc4_;
            _loc5_=new ListEvent(ListEvent.ITEM_EDIT_BEGINNING,false,true);
            _loc5_.rowIndex=_loc2_;
            _loc5_.columnIndex=_loc3_;
            dispatchEvent(_loc5_);
            return true;
         }
         this.setEditedItemPosition(null);
         this.losingFocus=true;
         setFocus();
         return false;
      }

      public function destroyItemEditor() : void {
         var _loc1_:ListEvent = null;
         if(this.itemEditorInstance)
         {
            DisplayObject(this.itemEditorInstance).removeEventListener(KeyboardEvent.KEY_DOWN,this.editorKeyDownHandler);
            if(focusManager)
            {
               focusManager.defaultButtonEnabled=true;
            }
            systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_DOWN,this.editorMouseDownHandler,true);
            systemManager.getSandboxRoot().removeEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE,this.editorMouseDownHandler);
            _loc1_=new ListEvent(ListEvent.ITEM_FOCUS_OUT);
            _loc1_.rowIndex=this._editedItemPosition.rowIndex;
            _loc1_.itemRenderer=this.editedItemRenderer;
            dispatchEvent(_loc1_);
            if(!this.rendererIsEditor)
            {
               if((this.itemEditorInstance) && this.itemEditorInstance  is  UIComponent)
               {
                  UIComponent(this.itemEditorInstance).drawFocus(false);
               }
               listContent.removeChild(DisplayObject(this.itemEditorInstance));
            }
            this.itemEditorInstance=null;
            this._editedItemPosition=null;
         }
         return;
      }

      protected function endEdit(param1:String) : Boolean {
         if(!this.editedItemRenderer)
         {
            return true;
         }
         this.inEndEdit=true;
         var _loc2_:ListEvent = new ListEvent(ListEvent.ITEM_EDIT_END,false,true);
         _loc2_.rowIndex=this.editedItemPosition.rowIndex;
         _loc2_.itemRenderer=this.editedItemRenderer;
         _loc2_.reason=param1;
         dispatchEvent(_loc2_);
         this.dontEdit=!(this.itemEditorInstance == null);
         if(!this.dontEdit && param1 == ListEventReason.CANCELLED)
         {
            this.losingFocus=true;
            setFocus();
         }
         this.inEndEdit=false;
         return !_loc2_.isDefaultPrevented();
      }

      public function isItemEditable(param1:Object) : Boolean {
         if(!this.editable)
         {
            return false;
         }
         if(param1 == null)
         {
            return false;
         }
         return true;
      }

      override protected function mouseDownHandler(param1:MouseEvent) : void {
         var _loc2_:IListItemRenderer = null;
         var _loc3_:Sprite = null;
         var _loc5_:Point = null;
         var _loc6_:* = false;
         _loc2_=this.mouseEventToItemRenderer(param1);
         var _loc4_:Boolean = itemRendererContains(this.itemEditorInstance,DisplayObject(param1.target));
         if(!_loc4_)
         {
            if((_loc2_) && (_loc2_.data))
            {
               _loc5_=itemRendererToIndices(_loc2_);
               _loc6_=true;
               if(this.itemEditorInstance)
               {
                  _loc6_=this.endEdit(ListEventReason.NEW_ROW);
               }
               if(!_loc6_)
               {
                  return;
               }
            }
            else
            {
               if(this.itemEditorInstance)
               {
                  this.endEdit(ListEventReason.OTHER);
               }
            }
            super.mouseDownHandler(param1);
         }
         return;
      }

      override protected function mouseUpHandler(param1:MouseEvent) : void {
         var _loc2_:ListEvent = null;
         var _loc3_:IListItemRenderer = null;
         var _loc4_:Sprite = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:Point = null;
         _loc3_=this.mouseEventToItemRenderer(param1);
         super.mouseUpHandler(param1);
         if((_loc3_) && (_loc3_.data) && !(_loc3_ == this.itemEditorInstance))
         {
            _loc7_=itemRendererToIndices(_loc3_);
            if((this.editable) && !this.dontEdit)
            {
               _loc2_=new ListEvent(ListEvent.ITEM_EDIT_BEGINNING,false,true);
               _loc2_.rowIndex=_loc7_.y;
               _loc2_.columnIndex=0;
               _loc2_.itemRenderer=_loc3_;
               dispatchEvent(_loc2_);
            }
         }
         return;
      }

      override protected function focusInHandler(param1:FocusEvent) : void {
         var _loc2_:* = false;
         if(param1.target != this)
         {
            return;
         }
         if(this.losingFocus)
         {
            this.losingFocus=false;
            return;
         }
         super.focusInHandler(param1);
         if((this.editable) && !isPressed)
         {
            this._editedItemPosition=this.lastEditedItemPosition;
            _loc2_=!(this.editedItemPosition == null);
            if(!this._editedItemPosition)
            {
               this._editedItemPosition=
                  {
                     "rowIndex":0,
                     "columnIndex":0
                  }
               ;
               _loc2_=(listItems.length) && listItems[0].length > 0;
            }
            if(_loc2_)
            {
               this.setEditedItemPosition(this._editedItemPosition);
            }
         }
         if(this.editable)
         {
            addEventListener(FocusEvent.KEY_FOCUS_CHANGE,this.keyFocusChangeHandler);
            addEventListener(MouseEvent.MOUSE_DOWN,this.mouseFocusChangeHandler);
         }
         return;
      }

      override protected function focusOutHandler(param1:FocusEvent) : void {
         if(param1.target == this)
         {
            super.focusOutHandler(param1);
         }
         if(param1.relatedObject == this && (itemRendererContains(this.itemEditorInstance,DisplayObject(param1.target))))
         {
            return;
         }
         if(param1.relatedObject == null && (itemRendererContains(this.editedItemRenderer,DisplayObject(param1.target))))
         {
            return;
         }
         if(param1.relatedObject == null && (itemRendererContains(this.itemEditorInstance,DisplayObject(param1.target))))
         {
            return;
         }
         if((this.itemEditorInstance) && (!param1.relatedObject || !itemRendererContains(this.itemEditorInstance,param1.relatedObject)))
         {
            this.endEdit(ListEventReason.OTHER);
            removeEventListener(FocusEvent.KEY_FOCUS_CHANGE,this.keyFocusChangeHandler);
            removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseFocusChangeHandler);
         }
         return;
      }

      private function deactivateHandler(param1:Event) : void {
         if(this.itemEditorInstance)
         {
            this.endEdit(ListEventReason.OTHER);
            this.losingFocus=true;
            setFocus();
         }
         return;
      }

      override protected function keyDownHandler(param1:KeyboardEvent) : void {
         if(this.itemEditorInstance)
         {
            return;
         }
         super.keyDownHandler(param1);
         return;
      }

      private function editorMouseDownHandler(param1:Event) : void {
         if(param1  is  MouseEvent && (itemRendererContains(this.itemEditorInstance,DisplayObject(param1.target))))
         {
            return;
         }
         this.endEdit(ListEventReason.OTHER);
         this.losingFocus=true;
         setFocus();
         return;
      }

      private function editorKeyDownHandler(param1:KeyboardEvent) : void {
         if(param1.keyCode == Keyboard.ESCAPE)
         {
            this.endEdit(ListEventReason.CANCELLED);
         }
         else
         {
            if((param1.ctrlKey) && param1.charCode == 46)
            {
               this.endEdit(ListEventReason.CANCELLED);
            }
            else
            {
               if(param1.charCode == Keyboard.ENTER && !(param1.keyCode == 229))
               {
                  if(this.editorUsesEnterKey)
                  {
                     return;
                  }
                  if((this.endEdit(ListEventReason.NEW_ROW)) && !this.dontEdit)
                  {
                     this.findNextEnterItemRenderer(param1);
                     if(focusManager)
                     {
                        focusManager.defaultButtonEnabled=false;
                     }
                  }
               }
            }
         }
         return;
      }

      private function findNextEnterItemRenderer(param1:KeyboardEvent) : void {
         if(this._proposedEditedItemPosition !== undefined)
         {
            return;
         }
         this._editedItemPosition=this.lastEditedItemPosition;
         var _loc2_:int = this._editedItemPosition.rowIndex;
         var _loc3_:int = this._editedItemPosition.columnIndex;
         var _loc4_:int = this._editedItemPosition.rowIndex + (param1.shiftKey?-1:1);
         if(_loc4_ < collection.length && _loc4_ >= 0)
         {
            _loc2_=_loc4_;
         }
         var _loc5_:ListEvent = new ListEvent(ListEvent.ITEM_EDIT_BEGINNING,false,true);
         _loc5_.rowIndex=_loc2_;
         _loc5_.columnIndex=0;
         dispatchEvent(_loc5_);
         return;
      }

      private function mouseFocusChangeHandler(param1:MouseEvent) : void {
         if((this.itemEditorInstance) && (!param1.isDefaultPrevented()) && (itemRendererContains(this.itemEditorInstance,DisplayObject(param1.target))))
         {
            param1.preventDefault();
         }
         return;
      }

      private function keyFocusChangeHandler(param1:FocusEvent) : void {
         if(param1.keyCode == Keyboard.TAB && !param1.isDefaultPrevented() && (this.findNextItemRenderer(param1.shiftKey)))
         {
            param1.preventDefault();
         }
         return;
      }

      private function itemEditorFocusOutHandler(param1:FocusEvent) : void {
         if((param1.relatedObject) && (contains(param1.relatedObject)))
         {
            return;
         }
         if(!param1.relatedObject)
         {
            return;
         }
         if(this.itemEditorInstance)
         {
            this.endEdit(ListEventReason.OTHER);
         }
         return;
      }

      private function itemEditorItemEditBeginningHandler(param1:ListEvent) : void {
         if(!param1.isDefaultPrevented())
         {
            this.setEditedItemPosition(
               {
                  "columnIndex":param1.columnIndex,
                  "rowIndex":param1.rowIndex
               }
            );
         }
         else
         {
            if(!this.itemEditorInstance)
            {
               this._editedItemPosition=null;
               this.editable=false;
               setFocus();
               this.editable=true;
            }
         }
         return;
      }

      private function itemEditorItemEditBeginHandler(param1:ListEvent) : void {
         var _loc2_:IFocusManager = null;
         if(root)
         {
            systemManager.addEventListener(Event.DEACTIVATE,this.deactivateHandler,false,0,true);
         }
         if(!param1.isDefaultPrevented() && !(listItems[this.actualRowIndex][this.actualColIndex].data == null))
         {
            this.createItemEditor(param1.columnIndex,param1.rowIndex);
            if(this.editedItemRenderer  is  IDropInListItemRenderer && this.itemEditorInstance  is  IDropInListItemRenderer)
            {
               IDropInListItemRenderer(this.itemEditorInstance).listData=IDropInListItemRenderer(this.editedItemRenderer).listData;
            }
            if(!this.rendererIsEditor)
            {
               this.itemEditorInstance.data=this.editedItemRenderer.data;
            }
            if(this.itemEditorInstance  is  IInvalidating)
            {
               IInvalidating(this.itemEditorInstance).validateNow();
            }
            if(this.itemEditorInstance  is  IIMESupport)
            {
               IIMESupport(this.itemEditorInstance).imeMode=this.imeMode;
            }
            _loc2_=focusManager;
            if(this.itemEditorInstance  is  IFocusManagerComponent)
            {
               _loc2_.setFocus(IFocusManagerComponent(this.itemEditorInstance));
            }
            param1=new ListEvent(ListEvent.ITEM_FOCUS_IN);
            param1.rowIndex=this._editedItemPosition.rowIndex;
            param1.itemRenderer=this.itemEditorInstance;
            dispatchEvent(param1);
         }
         return;
      }

      private function itemEditorItemEditEndHandler(param1:ListEvent) : void {
         var bChanged:Boolean = false;
         var bFieldChanged:Boolean = false;
         var newData:Object = null;
         var data:Object = null;
         var editCollection:IList = null;
         var listData:BaseListData = null;
         var fm:IFocusManager = null;
         var event:ListEvent = param1;
         if(!event.isDefaultPrevented())
         {
            bChanged=false;
            bFieldChanged=false;
            newData=this.itemEditorInstance[this.editorDataField];
            data=event.itemRenderer.data;
            if(data  is  String)
            {
               if(!(newData  is  String))
               {
                  newData=newData.toString();
               }
            }
            else
            {
               if(data  is  uint)
               {
                  if(!(newData  is  uint))
                  {
                     newData=uint(newData);
                  }
               }
               else
               {
                  if(data  is  int)
                  {
                     if(!(newData  is  int))
                     {
                        newData=int(newData);
                     }
                  }
                  else
                  {
                     if(data  is  Number)
                     {
                        if(!(newData  is  int))
                        {
                           newData=Number(newData);
                        }
                     }
                     else
                     {
                        bFieldChanged=true;
                        try
                        {
                           data[labelField]=newData;
                           if(!(data  is  IPropertyChangeNotifier))
                           {
                              if(actualCollection)
                              {
                                 actualCollection.itemUpdated(data,labelField);
                              }
                              else
                              {
                                 collection.itemUpdated(data,labelField);
                              }
                           }
                        }
                        catch(e:Error)
                        {
                           trace("attempt to write to",labelField,"failed.  You may need a custom ITEM_EDIT_END handler");
                        }
                     }
                  }
               }
            }
            if(!bFieldChanged)
            {
               if(data !== newData)
               {
                  bChanged=true;
                  data=newData;
               }
               if(bChanged)
               {
                  editCollection=actualCollection?actualCollection as IList:collection as IList;
                  if(editCollection)
                  {
                     IList(editCollection).setItemAt(data,event.rowIndex);
                  }
                  else
                  {
                     trace("attempt to update collection failed.  You may need a custom ITEM_EDIT_END handler");
                  }
               }
            }
            if(event.itemRenderer  is  IDropInListItemRenderer)
            {
               listData=BaseListData(IDropInListItemRenderer(event.itemRenderer).listData);
               listData.label=itemToLabel(data);
               IDropInListItemRenderer(event.itemRenderer).listData=listData;
            }
            delete visibleData[[itemToUID(event.itemRenderer.data)]];
            event.itemRenderer.data=data;
            visibleData[itemToUID(data)]=event.itemRenderer;
         }
         else
         {
            if(event.reason != ListEventReason.OTHER)
            {
               if((this.itemEditorInstance) && (this._editedItemPosition))
               {
                  if(selectedIndex != this._editedItemPosition.rowIndex)
                  {
                     selectedIndex=this._editedItemPosition.rowIndex;
                  }
                  fm=focusManager;
                  if(this.itemEditorInstance  is  IFocusManagerComponent)
                  {
                     fm.setFocus(IFocusManagerComponent(this.itemEditorInstance));
                  }
               }
            }
         }
         if(event.reason == ListEventReason.OTHER || !event.isDefaultPrevented())
         {
            this.destroyItemEditor();
         }
         return;
      }

      override protected function drawHighlightIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void {
         super.drawHighlightIndicator(param1,0,param3,unscaledWidth - viewMetrics.left - viewMetrics.right,param5,param6,param7);
         return;
      }

      override protected function drawCaretIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void {
         super.drawCaretIndicator(param1,0,param3,unscaledWidth - viewMetrics.left - viewMetrics.right,param5,param6,param7);
         return;
      }

      override protected function drawSelectionIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void {
         super.drawSelectionIndicator(param1,0,param3,unscaledWidth - viewMetrics.left - viewMetrics.right,param5,param6,param7);
         return;
      }

      override protected function mouseWheelHandler(param1:MouseEvent) : void {
         if(this.itemEditorInstance)
         {
            this.endEdit(ListEventReason.OTHER);
         }
         super.mouseWheelHandler(param1);
         return;
      }

      override protected function collectionChangeHandler(param1:Event) : void {
         var _loc2_:CollectionEvent = null;
         if(param1  is  CollectionEvent)
         {
            _loc2_=CollectionEvent(param1);
            if(_loc2_.kind == CollectionEventKind.REMOVE)
            {
               if(this.editedItemPosition)
               {
                  if(collection.length == 0)
                  {
                     if(this.itemEditorInstance)
                     {
                        this.endEdit(ListEventReason.CANCELLED);
                     }
                     this.setEditedItemPosition(null);
                  }
                  else
                  {
                     if(_loc2_.location <= this.editedItemPosition.rowIndex)
                     {
                        if(this.inEndEdit)
                        {
                           this._editedItemPosition=
                              {
                                 "columnIndex":this.editedItemPosition.columnIndex,
                                 "rowIndex":Math.max(0,this.editedItemPosition.rowIndex - _loc2_.items.length)
                              }
                           ;
                        }
                        else
                        {
                           this.setEditedItemPosition(
                              {
                                 "columnIndex":this.editedItemPosition.columnIndex,
                                 "rowIndex":Math.max(0,this.editedItemPosition.rowIndex - _loc2_.items.length)
                              }
                           );
                        }
                     }
                  }
               }
            }
         }
         super.collectionChangeHandler(param1);
         return;
      }

      mx_internal function callSetupRendererFromData(param1:IListItemRenderer, param2:Object) : void {
         this.setupRendererFromData(param1,param2);
         return;
      }

      mx_internal function callMakeListData(param1:Object, param2:String, param3:int) : BaseListData {
         return this.makeListData(param1,param2,param3);
      }
   }

}