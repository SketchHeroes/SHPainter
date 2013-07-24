package mx.skins
{
   import mx.core.IBorder;
   import mx.core.mx_internal;
   import mx.core.EdgeMetrics;

   use namespace mx_internal;

   public class Border extends ProgrammaticSkin implements IBorder
   {
      public function Border() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public function get borderMetrics() : EdgeMetrics {
         return EdgeMetrics.EMPTY;
      }
   }

}