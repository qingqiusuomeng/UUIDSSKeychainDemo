由于我们后台判断App登录时根据唯一标识来判断的在不同终端登录的，如果唯一标识不一样，说明是换了设备，但是我们的用户名密码是我们同一系列的app公用的，所以得保证同一公司旗下的app在同一设备下的唯一标识是同一个，避免出现同一设备登陆同一系列其他app时提示换了设备，说个简单的例子

如：我的用户名是aaa，淘宝和支付宝可以共用，在我的手机上我可以用aaa同时登陆淘宝和支付宝，但是如果我在另一个手机上使用aaa，那么就需要提示用户换了设备 1.UDID(Unique Device Identifier)

//UUID , 已废除

NSString *udid = [[UIDevice currentDevice] uniqueIdentifier];
UDID的全称是Unique Device Identifier，它就是苹果iOS设备的唯一识别码，它由40位16进制数的字母和数字组成（越狱的设备通过某些工具可以改变设备的UDID）。移动网络可利用UDID来识别移动设备，但是，从IOS5.0（2011年8月份）开始，苹果宣布将不再支持用uniqueIdentifier方法获取设备的UDID，iOS5以下是可以用的。苹果从iOS5开始就移除了通过代码访问UDID的权限。从2013年5月1日起，试图访问UIDIDs的程序将不再被审核通过，替代的方案是开发者应该使用“在iOS 6中介绍的Vendor或Advertising标示符”。所以UDID是绝对是不能再使用了。 为什么苹果反对开发人员使用UDID？
iOS 2.0版本以后UIDevice提供一个获取设备唯一标识符的方法uniqueIdentifier，通过该方法我们可以获取设备的序列号，这个也是目前为止唯一可以确认唯一的标示符。 许多开发者把UDID跟用户的真实姓名、密码、住址、其它数据关联起来；网络窥探者会从多个应用收集这些数据，然后顺藤摸瓜得到这个人的许多隐私数据。同时大部分应用确实在频繁传输UDID和私人信息。 为了避免集体诉讼，苹果最终决定在iOS 5 的时候，将这一惯例废除，开发者被引导生成一个唯一的标识符，只能检测应用程序，其他的信息不提供。现在应用试图获取UDID已被禁止且不允许上架。

2.UUID(Universally Unique Identifier)

是基于iOS设备上面某个单个的应用程序，只要用户没有完全删除应用程序，则这个UUID在用户使用该应用程序的时候一直保持不变。如果用户删除了这个应用程序，然后再重新安装，那么这个UUID已经发生了改变。 同一设备上的不同应用的UUID是互斥的，即能在改设备上标识应用。所以一些人推测，这个UUID应该是根据设备标识和应用标识生成唯一标识，再经过加密而来的(纯推测)。 官方推荐的方法是，每个应用内创建一个UUID来作为唯一标志，并将之存储，但是这个解决方法明显不能接受！ 缺点：

你每次创建的UUID都是不一样的，意味着，你卸载后重新安装这个软件，生成的UUID就不一样了，无法达到我们将之作为数据分析的唯一标识符的要求。 关于获取UUID的代码：

[[UIDevice currentDevice] identifierForVendor]； 不过，设备唯一标示的问题仍然没有解决：如果你删除应用然后再次安装，这个identifierForVendor的值就变了。

3.open UDID

在iOS 5发布时，uniqueIdentifier被弃用了，这引起了广大开发者需要寻找一个可以替代UDID，并且不受苹果控制的方案。由此OpenUDID成为了当时使用最广泛的开源UDID替代方案。OpenUDID在工程中实现起来非常简单，并且还支持一系列的广告提供商。

OpenUDID利用了一个非常巧妙的方法在不同程序间存储标示符 — 在粘贴板中用了一个特殊的名称来存储标示符。通过这种方法，别的程序（同样使用了OpenUDID）知道去什么地方获取已经生成的标示符（而不用再生成一个新的）。而且根据贡献者的代码和方法，和一些开发者的经验，如果把使用了OpenUDID方案的应用全部都删除，再重新获取OpenUDID，此时的OpenUDID就跟以前的不一样。可见，这种方法还是不保险。 但是OpenUDID库早已经弃用了, 在其官方的博客中也指明了, 停止维护OpenUDID的原因是为了更好的向苹果的举措靠拢, 还指明了MAC Address不是一个好的选择。

4.MAC Address

4.1.这个MAC地址是指什么？有什么用？

MAC(Medium/Media Access Control)地址，用来表示互联网上每一个站点的标识符，采用十六进制数表示，共六个字节（48位）。其中，前三个字节是由IEEE的注册管理机构 RA负责给不同厂家分配的代码(高位24位)，也称为“编制上唯一的标识符” （Organizationally Unique Identifier)，后三个字节(低位24位)由各厂家自行指派给生产的适配器接口，称为扩展标识符（唯一性）。 MAC地址在网络上用来区分设备的唯一性，接入网络的设备都有一个MAC地址，他们肯定都是不同的，是唯一的。一部iPhone上可能有多个MAC地址，包括WIFI的、SIM的等，但是iTouch和iPad上就有一个WIFI的，因此只需获取WIFI的MAC地址就好了，也就是en0的地址。 形象的说，MAC地址就如同我们身份证上的身份证号码，具有全球唯一性。这样就可以非常好的标识设备唯一性，类似与苹果设备的UDID号，通常的用途有： 1）用于一些统计与分析目的，利用用户的操作习惯和数据更好的规划产品； 2）作为用户ID来唯一识别用户，可以用游客身份使用app又能在服务器端保存相应的信息，省去用户名、密码等注册过程。

4.2.如何使用Mac地址生成设备的唯一标识呢？

主要分三种： 1、直接使用“MAC Address” 2、使用“MD5(MAC Address)” 3、使用“MD5(Mac Address+bundle_id)”获得“机器＋应用”的唯一标识（bundle_id 是应用的唯一标识）

iOS7之前，因为Mac地址是唯一的， 一般app开发者会采取第3种方式来识别安装对应app的设备。为什么会使用它？在iOS5之前，都是使用UDID的，后来被禁用。苹果推荐使用UUID 但是也有诸多问题，从而使用MAC地址。而MAC地址跟UDID一样，存在隐私问题，现在苹果新发布的iOS7上，如果请求Mac地址都会返回一个固定值，那么Mac Address+bundle_id这个值大家的设备都变成一致的啦，跟UDID一样相当于被禁用, 所以Mac Address 是不能够被使用为获取设备唯一标识的。

5.广告标示符（IDFA-identifierForIdentifier）

广告标识符，在同一个设备上的所有App都会取到相同的值，是苹果专门给各广告提供商用来追踪用户而设的。但好在Apple默认是允许追踪的，而且一般用户都不知道有这么个设置，所以基本上用来监测推广效果，是戳戳有余了。 它是iOS 6中另外一个新的方法，提供了一个方法advertisingIdentifier，通过调用该方法会返回一个NSUUID实例，最后可以获得一个UUID，由系统存储着的。

#import <AdSupport/AdSupport.h> NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]; 1 2 不过即使这是由系统存储的，但是有几种情况下，会重新生成广告标示符。如果用户完全重置系统（(设置程序 -> 通用 -> 还原 -> 还原位置与隐私) ，这个广告标示符会重新生成。另外如果用户明确的还原广告(设置程序-> 通用 -> 关于本机 -> 广告 -> 还原广告标示符) ，那么广告标示符也会重新生成。 关于广告标示符的还原，有一点需要注意：如果程序在后台运行，此时用户“还原广告标示符”，然后再回到程序中，此时获取广 告标示符并不会立即获得还原后的标示符。必须要终止程序，然后再重新启动程序，才能获得还原后的广告标示符。 所以IDFA也不可以作为获取唯一标识的方法，来识别用户。

6.Vendor标示符 (IDFV-identifierForVendor)

Vendor标示符，是给Vendor标识用户用的，每个设备在所属同一个Vender的应用里，都有相同的值。其中的Vender是指应用提供商，但准确点说，是通过BundleID的反转的前两部分进行匹配，如果相同就是同一个Vender，例如对于com.taobao.app1, com.taobao.app2 这两个BundleID来说，就属于同一个Vender，共享同一个IDFV的值。和IDFA不同的是，IDFV的值是一定能取到的，所以非常适合于作为内部用户行为分析的主id，来标识用户，替代OpenUDID。 它是iOS 6中新增的，跟advertisingIdentifier一样，该方法返回的是一个 NSUUID对象，可以获得一个UUID。如果满足条件“相同的一个程序里面-相同的vendor-相同的设备”，那么获取到的这个属性值就不会变。如果是“相同的程序-相同的设备-不同的vendor，或者是相同的程序-不同的设备-无论是否相同的vendor”这样的情况，那么这个值是不会相同的。

NSString *strIDFV = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
1 但是如果用户将属于此Vender的所有App卸载，则IDFV的值会被重置，即再重装此Vender的App，IDFV的值和之前不同。

7.推送token＋bundle_id

推送token＋bundle_id的方法： 1、应用中增加推送用来获取token 2、获取应用bundle_id 3、根据token+bundle_id进行散列运算

apple push token保证设备唯一，但必须有网络情况下才能工作，该方法并不是依赖于设备本身，而是依赖于apple push机制，所以当苹果push做出改变时, 你获取所谓的唯一标识也就随之失效了。所以此方法还是不可取的。

获取设备唯一标识符的推荐新方案
思路：

通过调用CFFUUIDCreate函数来生成机器唯一标识符UUID。但每次调用该函数返回的字符串都不一样，所以第一次调用后需把该字符串存储起来。 尽管CFFUUIDCreate每次获取的UUID会发生变化，最理想的是可以保存在钥匙串keychain里面，并以此作为标识用户设备的唯一标识符。 2.1 关于获取UUID的官方方案

关于获取UUID，这是官方API的建议方法:

(NSString *) uniqueString { CFUUIDRef unique = CFUUIDCreate(kCFAllocatorDefault); NSString *result = [(NSString *)CFUUIDCreateString(kCFAllocatorDefault, unique) autorelease]; CFRelease(unique); return result; } 2.2 基于SSKeychain的唯一识别码方案
如上获取的UUID，基于Git上的一个第三方库SSKeychain，可以将UUID保存在keychain里面，每次调用先检查钥匙串里面有没有，有则使用，没有则写进去，保证其唯一性，

参考代码：

(NSString *)getDeviceUUID {

NSString *uuidStr = [SSKeychain passwordForService:@"com.test.app1" account:@"user"]; if (!uuidStr || [uuidStr isEqualToString:@""]) { CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault); uuidStr = (__bridge NSString *)CFUUIDCreateString(kCFAllocatorDefault ,uuidRef); [SSKeychain setPassword:[NSString stringWithFormat:@"%@", uuidStr] forService:@"com.test.app1"account:@"user"]; } return uuidStr; }

如果需要同一系列产品共用唯一标识，参考博客：https://blog.csdn.net/qq_33298465/article/details/80333490
