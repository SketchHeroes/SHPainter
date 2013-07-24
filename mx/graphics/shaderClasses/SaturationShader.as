package mx.graphics.shaderClasses
{
   import flash.display.Shader;


   public class SaturationShader extends Shader
   {
      public function SaturationShader() {
         super(new ShaderClass());
         return;
      }

      private static var ShaderClass:Class = SaturationShader_ShaderClass;
   }

}