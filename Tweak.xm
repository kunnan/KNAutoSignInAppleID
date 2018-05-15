
#import "KNHook.h"

// >   [[UIApplication sharedApplication] launchApplicationWithIdentifier:@"com.tencent.xin" suspended:0];//方式二

%hook PreferencesAppController
- (_Bool)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2{

   	%orig;

	// [KNHook hookClass:@"StoreSettingsController"];//SBApplication  SBSetupWiFiScanner
}

%end

%hook StoreSettingsController


-(char)_isSignInEnabled{

	return YES;
}

%end


// %hook PSUIPrefsListController
%hook PrefsListController

- (void)viewDidLoad {//打开app store 
	%orig;
	NSLog(@"=============tt=============>");
	//[ClassUtil showClassInfo:self isShow:YES];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:3];
	[self tableView:[self table] didSelectRowAtIndexPath: indexPath];
}

%end

%hook PSListController

- (void)viewDidAppear:(BOOL)animated {
	%orig;
	//[ClassUtil showClassInfo:self isShow:YES];
    NSString *selfClass = NSStringFromClass([self class]);
	NSLog(@"========================当前类名=>%@",selfClass);// orig_patch is /var/mobile/Library/Cookies/com.apple.itunesstored.2.sqlitedb

	NSString * str = @"StoreSettingsController";
	if ([str isEqualToString:selfClass]) {
		NSLog(@"==================成功=========>");
		UITableView * table = [self logViewHierarchy];
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
		//UITableView * table = [ClassUtil getPublicVarsFromKey:self fromKey:@"table"];
		if (table == nil){
			NSLog(@"==================nil=========>");
			return;
		}
		// [self tableView:table didSelectRowAtIndexPath: indexPath];// 输入账号
	// Ivar _appleIDm_arrVerifyContactWrap = class_getInstanceVariable(objc_getClass("StoreSettingsController"), "_appleID");
	// object_setIvar(self, _appleIDm_arrVerifyContactWrap, @"@qq.com");

	// [0x172a0e00 _setAppleID:@"@qq.com"];

	// Ivar _password_appleIDm_arrVerifyContactWrap = class_getInstanceVariable(objc_getClass("StoreSettingsController"), "_password");
	// object_setIvar(self, _password_appleIDm_arrVerifyContactWrap, @"");

	//点击登录
	 // [self tableView:table didSelectRowAtIndexPath: indexPath];// 输入账号
	// PSSpecifier *music_video = [PSSpecifier preferenceSpecifierNamed:@"test555" target:nil set:NULL get:NULL detail:NULL cell:PSSwitchCell edit:NULL];

	 // [self _signIn];

	 // -(void)_signInButton:(id)arg1 ;

// ;
	// [self _signInButton:[[%c(PSSpecifier) preferenceSpecifierNamed:@"SIGN_IN" target:self set:NULL get:NULL detail:NULL cell:@"PSSwitchCell" edit:NULL]  setProperty:[NSSet setWithArray:@[@"music-video"]] forKey:@"SSDownloadKinds"]];//PSSpecifier
//StoreSettingsAccountCell 
	//- (nullable __kindof UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;   // returns nil if cell is not visible or index path is out of range
	UITableViewCell *cell =  [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
	// [[cell textLabel] setText:@"ett"];// 设置的是标题
		// [cell setValue:@"ett"];// 设置的是标题
		// [[cell detailTextLabel] setText:@"ett"];// 设置的是标题
	[[cell textField] setText:@"@qq.com"];
	cell =  [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
	[[cell textField] setText:@""];
		// NSLog(@"editingStyle:%@ cell:%@",[cell editingStyle],cell);//PSEditableTableCell
	[self _signIn];
	}
}

%new
- (UITableView *)logViewHierarchy {
	NSLog(@"%@", self);
	UIViewController * baseController =(UIViewController *) self;
	for (UIView *subview in baseController.view.subviews){
		if ([subview isKindOfClass:[UITableView class]]) {
			NSLog(@"找到相关的对象");
			return(UITableView *) subview;//#import <UIKit/UICompatibilityInputViewController.h>
		}
	}
	NSLog(@"抱歉没找到的对象");
	return nil;
}

	%end
