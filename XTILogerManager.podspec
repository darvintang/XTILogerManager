Pod::Spec.new do |s|
  s.name         = "XTILogerManager"
  s.version      = "0.0.4"
  s.summary      = "一个OC的用于打印、保存日志的组件"
  s.description  = <<-DESC
                  可以将日志文件压缩后通过系统的共享发送出去
                   DESC
  s.homepage     = "https://github.com/xt-input/XTILogerManager"
  s.license      = "MIT"
  s.authors      = {"input" => "input@tcoding.cn"}
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/xt-input/XTILogerManager.git",
                     :tag => s.version }
  s.subspec 'XTILoger' do |ss|
    ss.source_files = 'Source/XTILoger/*.{h,m}'
  end
  s.resources = 'Source/Manager/**/*.xib'
  s.resource_bundles = {
    'XTILogerManager' => [
    'Source/Manager/**/*.xib'
    ]
  }
  s.source_files = 'Source/Manager/**/*.{h,m}'
  s.dependency 'SSZipArchive'
  s.dependency 'MBProgressHUD'
  s.requires_arc  = true

end
