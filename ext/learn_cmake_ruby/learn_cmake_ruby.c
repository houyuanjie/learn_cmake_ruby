#include <ruby.h>
#include <hello.h>

VALUE rb_mLearnCmakeRuby;
VALUE rb_mHello;

VALUE rb_hello_get_message(VALUE self)
{
    char cstr[100];
    get_message(cstr, sizeof(cstr) / sizeof(char));
    VALUE str = rb_str_new_cstr(cstr);
    return str;
}

void Init_learn_cmake_ruby()
{
    rb_mLearnCmakeRuby = rb_define_module("LearnCmakeRuby");
    rb_mHello = rb_define_module_under(rb_mLearnCmakeRuby, "Hello");
    rb_define_module_function(rb_mHello, "message", rb_hello_get_message, 0);
}
