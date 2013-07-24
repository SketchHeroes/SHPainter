package mx.graphics.shaderClasses
{
   import flash.display.Shader;


   public class ExclusionShader extends Shader
   {
      public function ExclusionShader() {
         super(new ShaderClass());
         return;
      }

      private static var ShaderClass:Class = ExclusionShader_ShaderClass;
   }

}