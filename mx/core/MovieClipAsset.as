package mx.core
{

   use namespace mx_internal;

   public class MovieClipAsset extends FlexMovieClip implements IFlexAsset, IFlexDisplayObject, IBorder
   {
      public function MovieClipAsset() {
         super();
         this._measuredWidth=width;
         this._measuredHeight=height;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private var _measuredHeight:Number;

      public function get measuredHeight() : Number {
         return this._measuredHeight;
      }

      private var _measuredWidth:Number;

      public function get measuredWidth() : Number {
         return this._measuredWidth;
      }

      public function get borderMetrics() : EdgeMetrics {
         if(scale9Grid == null)
         {
            return EdgeMetrics.EMPTY;
         }
         return new EdgeMetrics(scale9Grid.left,scale9Grid.top,Math.ceil(this.measuredWidth - scale9Grid.right),Math.ceil(this.measuredHeight - scale9Grid.bottom));
      }

      public function move(param1:Number, param2:Number) : void {
         this.x=param1;
         this.y=param2;
         return;
      }

      public function setActualSize(param1:Number, param2:Number) : void {
         width=param1;
         height=param2;
         return;
      }
   }

}