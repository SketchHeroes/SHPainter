package components
{
   import mx.core.MovieClipLoaderAsset;
   import flash.utils.ByteArray;


   public class BrushChooser__embed_mxml_brushes_brush1_swf_1317320169 extends MovieClipLoaderAsset
   {
      public function BrushChooser__embed_mxml_brushes_brush1_swf_1317320169() {
         this.dataClass=BrushChooser__embed_mxml_brushes_brush1_swf_1317320169_dataClass;
         super();
         initialWidth=400 / 20;
         initialHeight=400 / 20;
         return;
      }

      private static var bytes:ByteArray = null;

      override public function get movieClipData() : ByteArray {
         if(bytes == null)
         {
            bytes=ByteArray(new this.dataClass());
         }
         return bytes;
      }

      public var dataClass:Class;
   }

}