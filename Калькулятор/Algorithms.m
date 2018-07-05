#import <Foundation/Foundation.h>
#import "Stack.h"

int getPriority(char chr) {
    switch (chr)
    {
        case '(':
            return 1;
        case '+': case '-':
            return 2;
        case '*': case '/':
            return 3;
        case '^':
            return 4;
        case ')':
            return 5;
        default:
            if(isdigit((char)chr))
                return 0;
            else
                return -1;
    }
}

NSString* INtoOPN(NSString* str)
{
    NSString* r_string=@"";
    Stack *ss=[[Stack alloc]init];
    
    char temp; int i=0;
    
    while([str characterAtIndex:i]==' '&&i+1<[str length])i++;
    
    if(i==[str length]-1) return 0;
    
    { //Проверка первого символа
        int f=getPriority([str characterAtIndex:i]);
        if(f>2) return 0;
    }
    
    if([str characterAtIndex:i]=='-') {
        r_string=@"- "; i++;
        while([str characterAtIndex:i]==' '&&i+1<[str length])i++;
        if(i==[str length]-1) return 0;
    }
    
    do{
        temp=[str characterAtIndex:i++];
        if(temp==' ') continue;
        int p=getPriority(temp);
        
        if(i<[str length]) //Знаки идущие подряд
        {
            if(p>0&&p!=1&&p!=5)
            {
                int f=getPriority([str characterAtIndex:i]);
                if(f>1&&f!=5) return 0;
            }
        }
        
        switch(p)
        {
            case 0: // число
                while((isdigit(temp)||temp=='.')&&i<=[str length]){
                    r_string=[NSString stringWithFormat: @"%@%c",r_string,temp];
                    if(i<[str length])temp=[str characterAtIndex:i++]; else {i++;break;}
                }i--;
                r_string=[NSString stringWithFormat: @"%@ ",r_string];
                break;
                
            case 1: // '('
                [ss push:[NSString stringWithFormat: @"%c",temp]];
                
                if([str characterAtIndex:i]=='-') {
                    r_string=[NSString stringWithFormat: @"%@- ",r_string]; i++;
                    while([str characterAtIndex:i]==' '&&i+1<[str length])i++;
                    if(i==[str length]-1) return 0;
                }
                break;
                
            case 5: // ')'
                while(![[ss view:0] isEqual:@"("])
                    r_string=[NSString stringWithFormat: @"%@%@",r_string,[ss pop]];
                [ss pop];
                break;
                
            case -1:
                return 0;
                
            default:
                if([ss count]==0 || getPriority([[ss view:0] characterAtIndex:0])<p)
                    [ss push:[NSString stringWithFormat:@"%c",temp]];
                else
                    if(getPriority([[ss view:0] characterAtIndex:0])>=p)
                    {
                        while(getPriority([[ss view:0] characterAtIndex:0])>=p)
                            r_string=[NSString stringWithFormat: @"%@%@",r_string,[ss pop]];
                        [ss push:[NSString stringWithFormat:@"%c",temp]];
                    }
        }
    }while(i<[str length]);
    
    { //Проверка последнего символа
        int f=getPriority([str characterAtIndex:i-1]);
        if(f>0&f!=5) return 0;
    }
    
    while([ss count]!=0)
    {
        if([[ss view:0] characterAtIndex:0]!='(') //Проверка на (
            r_string=[NSString stringWithFormat: @"%@%@",r_string,[ss pop]];
        else return 0;
    }
    /*#ifdef DEBUG
    NSLog(@"%@ -> %@",str,r_string);
    #endif*/
    return r_string;
}
double calculate(NSString* str)
{
    if(str==0) return INFINITY;
    
    Stack *ss=[[Stack alloc]init];
    NSString* result;
    
    _Bool minus=0;
    char temp; int i=0;
    do{
        temp=[str characterAtIndex:i++];
        
        if(isdigit(temp)) {
            result=@"";
            if(minus==1) {result=@"-";minus=0;}
            while(temp!=' ')
            {
                result=[NSString stringWithFormat: @"%@%c",result,temp];
                if(i<[str length])temp=[str characterAtIndex:i++]; else break;
            }
        }
        else
        {
            double pop1=[[ss pop] doubleValue];
            double pop2=[[ss pop] doubleValue];
            switch(temp){
                case '+':
                    result=[@(pop2+pop1) stringValue];
                    break;
                    
                case '-':
                    if(i<[str length]-1){
                        if([str characterAtIndex:i]==' '&& isdigit([str characterAtIndex:i+1])){
                            minus=1;
                            result=[@(pop1) stringValue];
                            break;
                        }
                    }
                    result=[@(pop2-pop1) stringValue];
                    break;
                    
                case '*':
                    result=[@(pop2*pop1) stringValue];
                    break;
                    
                case '/':
                    if(pop1==0) return INFINITY;
                    result=[@(pop2/pop1) stringValue];
                    break;
                    
                case '^':
                    result=[@(pow(pop2,pop1)) stringValue];
                    break;
            }
/*#ifdef DEBUG
            if(minus==0&&temp!='>')
                NSLog(@"%.1f %c %.1f = %@",pop2,temp,pop1,result);
#endif*/
        }
        [ss push:result];
    }while(i<[str length]);
    return [result doubleValue];
}
