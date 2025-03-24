#include <ruby.h>

void Init_learn_cmake_ruby()
{
    rb_eval_string("puts %q(Hello Ruby!)");
}
