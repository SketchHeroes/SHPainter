package mx.graphics.shaderClasses
{
   import flash.display.Shader;


   public class LuminosityShader extends Shader
   {
      public function LuminosityShader() {
         super(new ShaderClass());
         return;
      }

      private static var ShaderClass:Class = LuminosityShader_ShaderClass;
   }

}