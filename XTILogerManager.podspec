Pod::Spec.new do |s|
  s.name         = "XTILogerManager"
  s.version      = "0.0.5"
  s.summary      = "一个OC的用于打印、保存日志的组件"
  s.description  = <<-DESC
  TODO:可以将日志文件压缩后通过系统的共享发送出去
                   DESC
  s.homepage     = "https://github.com/xt-input/XTILogerManager"
  s.license      = "MIT"
  s.authors      = {"input" => "input@tcoding.cn"}
  s.source       = { :git => "https://github.com/xt-input/XTILogerManager.git",
                     :tag => s.version.to_s }

  s.platform     = :ios, "9.0"

  s.subspec 'XTILoger' do |ss|
    ss.source_files = 'XTILogerManager/Classes/XTILoger/*.{h,m}'
  end

  s.resource_bundles = {
    'XTILogerManager' => [
    'XTILogerManager/Classes/Manager/**/*.xib'
    ]
  }

  s.source_files = 'XTILogerManager/Classes/Manager/**/*.{h,m}'
  s.dependency 'SSZipArchive'
  s.dependency 'MBProgressHUD'
  s.requires_arc  = true

end
