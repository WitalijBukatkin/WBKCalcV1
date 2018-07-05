#import "ViewController.h"
#import "Stack.h"

NSString* INtoOPN(NSString* str);
double calculate(NSString* str);

Stack *ss;
NSString* memory=0;

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}
- (IBAction)Button_1_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%c",[_Field_Expression stringValue],'1']];
}
- (IBAction)Button_2_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%c",[_Field_Expression stringValue],'2']];
}
- (IBAction)Button_3_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%c",[_Field_Expression stringValue],'3']];
}
- (IBAction)Button_4_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%c",[_Field_Expression stringValue],'4']];
}
- (IBAction)Button_5_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%c",[_Field_Expression stringValue],'5']];
}
- (IBAction)Button_6_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%c",[_Field_Expression stringValue],'6']];
}
- (IBAction)Button_7_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%c",[_Field_Expression stringValue],'7']];
}
- (IBAction)Button_8_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%c",[_Field_Expression stringValue],'8']];
}
- (IBAction)Button_9_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%c",[_Field_Expression stringValue],'9']];
}
- (IBAction)Button_0_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%c",[_Field_Expression stringValue],'0']];
}
//Kapo
- (IBAction)Button_Sqrt_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%@",[_Field_Expression stringValue],@"^0.5"]];
}
- (IBAction)Button_Pow_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%@",[_Field_Expression stringValue],@"^"]];
}
- (IBAction)Button_Punkt_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%c",[_Field_Expression stringValue],'.']];
}
- (IBAction)Button_BackSpace_Click:(id)sender {
    NSString *str=[_Field_Expression stringValue];
    if([str length]!=0){
        str=[str substringToIndex: [str length]-1];
        [_Field_Expression setStringValue:str];
    }
}
- (IBAction)Button_RemAll_Click:(id)sender {
    [_Field_Expression setStringValue:@""];
    [_Field_Result setStringValue:@"Введите выражение сюда ^"];
}
- (IBAction)Button_ÖffnendeKlammer_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%c",[_Field_Expression stringValue],'(']];
}
- (IBAction)Button_SchließendeKlammer_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%c",[_Field_Expression stringValue],')']];
}
- (IBAction)Button_Plus_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%c",[_Field_Expression stringValue],'+']];
}
- (IBAction)Button_Minus_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%c",[_Field_Expression stringValue],'-']];
}
- (IBAction)Button_Mal_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%c",[_Field_Expression stringValue],'*']];
}
- (IBAction)Button_DividiertDurch_Click:(id)sender {
    [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%c",[_Field_Expression stringValue],'/']];
}
- (IBAction)Button_Ergibt_Click:(id)sender {
    if([[_Field_Expression stringValue] isEqual: @""]) return;
    double result=calculate(INtoOPN([_Field_Expression stringValue]));
    if(result==INFINITY) {[_Field_Result setStringValue:@"Ошибка в выражении!"]; return;}
    [_Field_Result setStringValue:[NSString stringWithFormat:@"%f",result]];
    if([ss count]==0) ss=[[Stack alloc]init];
    [ss push:[NSString stringWithFormat:@"%@=%f",[_Field_Expression stringValue],result]];
}
//Memory
- (IBAction)Button_MemoryCopy_Click:(id)sender {
    if(![[_Field_Result stringValue] isEqual:@"Ошибка в выражении!"]&&![[_Field_Result stringValue] isEqual:@"Введите выражение сюда ^"])
        memory=[_Field_Result stringValue];
}
- (IBAction)Button_MemoryPaste_Click:(id)sender {
    if(memory!=0) [_Field_Expression setStringValue:[NSString stringWithFormat:@"%@%@",[_Field_Expression stringValue],memory]];
}
@end

@implementation HistoryViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    if([ss count]==0) [_HistoryView setString:@"История пуста!"];
    else{
        [_HistoryView setString:[NSString stringWithFormat:@"%@",[ss view:0]]];
        for(int i=1;i<[ss count];i++)
            [_HistoryView setString:[NSString stringWithFormat:@"%@\n%@",[_HistoryView string],[ss view:i]]];
    }
}
@end
