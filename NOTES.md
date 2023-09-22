# Background

- [[Far More than Everything You've Ever Wanted to Know about Prototypes in Perl -- by Tom Christiansen|https://www.perlmonks.org/?node_id=861966]]
- [[The Universe of Discourse : Guess what this does (solution)|https://blog.plover.com/2014/07/17/]]

# Syntax added in core Perl

- <https://metacpan.org/pod/feature>
- <https://metacpan.org/pod/experimental>
    * <https://metacpan.org/pod/experimentals>
- <https://metacpan.org/pod/less>
    * <https://metacpan.org/pod/fewer>
- <https://metacpan.org/pod/B::Keywords>
- "Secret" combinations of operators: <https://metacpan.org/dist/perlsecret>
- <https://metacpan.org/pod/Syntax::Construct>
- Fallbacks to backport features:
    * `try`/`catch`: <https://metacpan.org/pod/Feature::Compat::Try>
    * `defer`: <https://metacpan.org/pod/Feature::Compat::Defer>
    * `builtin`: <https://metacpan.org/pod/builtins::compat>, <https://metacpan.org/pod/builtin::compat>, <https://metacpan.org/pod/builtin::Backport>
    * `say`: <https://metacpan.org/pod/Say::Compat>, <https://metacpan.org/pod/say>
    * `class`: <https://metacpan.org/pod/Feature::Compat::Class> (feature not yet merged into perl5)
- Aliasing <https://www.effectiveperlprogramming.com/2015/08/create-named-variable-aliases-with-ref-aliasing/>
    * <https://metacpan.org/pod/Alias::Any>
    * <https://metacpan.org/pod/Data::Alias>
- Feature `current_sub`
    * <https://metacpan.org/pod/Sub::Current>
- Numerical
    * <https://perldoc.perl.org/integer>
    * <https://perldoc.perl.org/bigint>
    * <https://perldoc.perl.org/bignum>
    * <https://perldoc.perl.org/bigrat>

# Syntax extensions on CPAN

The following are various ways of extending the syntax. They might be
implemented as simple subroutine calls (e.g., used inline like `Try::Tiny`,
used as declarative code generators like `Moo`). They might be implemented as
source filters. They might use attributes. They might hook into the parser and
change how the code is interpreted. They might be implemented as keywords.

- `try`/`catch`
    * XS keyword plugin: <https://metacpan.org/pod/Syntax::Keyword::Try>
    * subs: <https://metacpan.org/pod/Try::Tiny>
        + <https://metacpan.org/pod/Try::Tiny::Tiny>
    * subs: <https://metacpan.org/pod/Try::Catch>
    * <https://metacpan.org/pod/TryCatch> (uses Devel::Declare)
    * XS keyword plugin: <https://metacpan.org/pod/Syntax::Feature::Try>
    * <https://metacpan.org/pod/Try> (uses Devel::CallParser + Try::Tiny)
- `async`/`await`
    * XS keyword plugin: <https://metacpan.org/pod/Future::AsyncAwait>
    * PPR-based source filter: <https://metacpan.org/pod/PerlX::AsyncAwait>
    * <https://metacpan.org/pod/Async::Trampoline>
    * <https://metacpan.org/pod/Mojo::AsyncAwait>
- signatures + parameters + return types
    * XS keyword plugin: <https://metacpan.org/pod/Function::Parameters>
    * <https://metacpan.org/pod/Method::Signatures> (uses Devel::Declare)
    * <https://metacpan.org/pod/Method::Signatures::Simple> (uses Devel::Declare)
    * <https://metacpan.org/pod/Smart::Args>
        + <https://metacpan.org/pod/Smart::Args::TypeTiny>
    * PPR-based source filter: <https://metacpan.org/pod/Method::Signatures::PP>
    * <https://metacpan.org/pod/signatures> (uses B::Hooks::Parser)
    * with currying
        + <https://metacpan.org/pod/Sub::Curried> (uses Devel::Declare)
        + <https://metacpan.org/pod/Attribute::Curried> (uses attributes)
    * attributes: <https://metacpan.org/pod/Return::Type>, <https://metacpan.org/pod/Return::Type::Lexical>
- multiple dispatch
    * XS keyword plugin: <https://metacpan.org/pod/Syntax::Keyword::MultiSub>
    * attributes: <https://metacpan.org/pod/Sub::Multi::Tiny>
    * <https://metacpan.org/pod/Class::Multimethods>
        + <https://www.foo.be/docs/tpj/issues/vol5_1/tpj0501-0010.html>
    * <https://metacpan.org/pod/Sub::MultiMethod>
    * <https://metacpan.org/pod/Sub::SymMethod>
    * <https://metacpan.org/pod/Sub::SmartMatch>
    * <https://metacpan.org/pod/Method::Cumulative>
- `defer`
    * XS keyword plugin: <https://metacpan.org/pod/Syntax::Keyword::Defer>
- Pipeline / flow-based
    * <https://metacpan.org/pod/Sub::Pipe> (operator overloading)
    * <https://metacpan.org/pod/Piper>
    * <https://metacpan.org/pod/Text::Pipe>
- OO
    * <https://perldoc.perl.org/fields> (in core)
    * <https://perldoc.perl.org/Class::Struct> (in core)
        + <https://metacpan.org/pod/Class::Struct>
    * <https://metacpan.org/pod/Object::Pad>
    * <https://metacpan.org/pod/Moops>
    * <https://metacpan.org/pod/Zydeco>
    * <https://metacpan.org/pod/Dios>
        + and multiple dispatch
        + and inside-out
    * Inside-out
        + <https://metacpan.org/pod/Hash::FieldHash>
        + <https://perldoc.perl.org/Hash::Util::FieldHash>
        + <https://metacpan.org/pod/Hash::Util::FieldHash::Compat>
        + <https://metacpan.org/pod/Class::Std>
        + <https://metacpan.org/pod/OO::InsideOut>
        + <https://metacpan.org/pod/Class::Tie::InsideOut>
        + <https://metacpan.org/pod/MooX::InsideOut>
        + <https://metacpan.org/pod/Class::InsideOut>
        + <https://metacpan.org/pod/MooseX::InsideOut>
        + <https://metacpan.org/pod/Object::InsideOut>
    * <https://metacpan.org/pod/Mic>
    * <https://metacpan.org/pod/Mite>
    * <https://metacpan.org/pod/Subclass::Of>
    * <https://metacpan.org/pod/With::Roles>
    * <https://metacpan.org/pod/Class::Accessor::Grouped>
    * Moose, Mouse, Moo, Mo, Mu, Role::Tiny, Class::Tiny
        + <https://metacpan.org/dist/MooseX-MungeHas>
        + <https://metacpan.org/pod/Sub::HandlesVia>
        + <https://metacpan.org/pod/CLI::Osprey>
        + <https://metacpan.org/pod/MooX::Should>
        + <https://metacpan.org/pod/MooX::Const>
    * method resolution
        + <https://metacpan.org/pod/MRO::Compat>
        + <https://metacpan.org/pod/Class::C3>
        + <https://metacpan.org/pod/MRO::Magic>
        + <https://metacpan.org/pod/subs::auto>
        + <https://metacpan.org/pod/NEXT>
        + <https://metacpan.org/pod/next::XS>
        + <https://metacpan.org/pod/CLASS>
        + <https://metacpan.org/pod/SUPER>
        + <https://metacpan.org/pod/mro::EVERY>
        + <https://metacpan.org/pod/sealed>
            + <https://www.sunstarsys.com/essays/perl7-sealed-lexicals>
    * <https://metacpan.org/pod/Object::Extend>
    * <https://metacpan.org/pod/Package::Variant>
    * <https://metacpan.org/pod/Object::Trampoline>
    * <https://metacpan.org/pod/Class::Implant> (mixins)
    * un-OO!? <https://metacpan.org/pod/Acme::CPANModules::Unbless>
- Operators
    * Smart-match
        + <https://metacpan.org/pod/match::smart>
        + <https://metacpan.org/pod/match::simple>
        + <https://metacpan.org/pod/Syntax::Feature::In>
        + <https://metacpan.org/pod/Scalar::In>
        + <https://metacpan.org/pod/Syntax::Keyword::Match>
    * `isa`
        + <https://metacpan.org/pod/isa>
    * For future perl infix operator support as described by <https://metacpan.org/pod/XS::Parse::Infix>
        + equ
            + <https://metacpan.org/pod/Syntax::Operator::Equ>
        + in
            + <https://metacpan.org/pod/Syntax::Operator::In>
        + zip
            + <https://metacpan.org/pod/Syntax::Operator::Zip>
        + divides
            + <https://metacpan.org/pod/Syntax::Operator::Divides>
        + matches
            + <https://metacpan.org/pod/Syntax::Operator::Matches>
    * Quote-likes
        + <https://metacpan.org/pod/PerlX::QuoteOperator> (uses Devel::Declare)
        + <https://metacpan.org/pod/Quote::Code> (XS keyword plugin)
        + <https://metacpan.org/pod/Quote::Ref> (XS keyword plugin)
        + <https://metacpan.org/pod/Quote::Reference> (uses source filter)
    * Non-det
        + <https://metacpan.org/pod/Amb>
        + <https://metacpan.org/pod/Quantum::Superpositions>
        + <https://metacpan.org/pod/Quantum::Superpositions::Lazy>
    * Gist with example of [Custom infix operators in perl5 · GitHub](https://gist.github.com/draegtun/540493)
- Types
    * syntax
        + attributes: <https://metacpan.org/pod/Attribute::Types>
        + tied variables: <https://metacpan.org/pod/Type::Tie>
        + magic: <https://metacpan.org/pod/Lexical::TypeTiny> (uses Variable::Magic + Lexical::Types)
        + <https://metacpan.org/pod/Variable::Declaration> (uses Keyword::Simple + Type::Tie)
        + <https://metacpan.org/pod/Lexical::Types>
    * checking / constraints
        + <https://github.com/Perl-Oshun/oshun>
        + <https://metacpan.org/dist/Perl-Types>
        + <https://metacpan.org/pod/Type::Tiny>
            + <https://typetiny.toby.ink/>
            + <https://metacpan.org/pod/Type::Registry#lookup($name)>
            + <https://metacpan.org/pod/Type::Params>
                + <https://blogs.perl.org/users/toby_inkster/2023/02/using-typeparams-effectively.html>
            + <https://metacpan.org/pod/Newtype>
        + <https://metacpan.org/pod/Mouse::Util::TypeConstraints>
        + <https://metacpan.org/pod/Specio>
        + <https://metacpan.org/pod/Moose::Meta::TypeConstraint>
            + <https://metacpan.org/pod/MooseX::Types>
        + <https://metacpan.org/pod/Data::Types>
        + assertion / DbC
            + <https://metacpan.org/pod/Sub::Contract>
            + <https://metacpan.org/pod/Class::DbC>
            + <https://metacpan.org/pod/Class::Contract>
            + <https://metacpan.org/pod/Attribute::Contract>
            + <https://metacpan.org/pod/Sub::Assert::Nothing>
            + <https://metacpan.org/pod/LIVR::Contract>
            + <https://metacpan.org/pod/MooseX::Contract>
            + <https://metacpan.org/pod/Class::Agreement>
            + <https://metacpan.org/pod/Assert::Refute>
            + <https://metacpan.org/pod/assertions>
            + <https://metacpan.org/pod/Generic::Assertions>
            + <https://metacpan.org/pod/Devel::Assert>
            + <https://metacpan.org/pod/Assert::Conditional>
            + <https://metacpan.org/pod/Carp::Assert::More>
            + <https://metacpan.org/pod/PerlX::Assert>
        + interface
            + <https://metacpan.org/pod/Function::Interface>
                + <https://speakerdeck.com/kfly8/interfaces-in-perl5-at-the-perl-conference-2019-in-pittsburgh>
            + <https://metacpan.org/pod/Role::Declare>
        + older
            + <https://metacpan.org/pod/typesafety>
            + <https://metacpan.org/pod/types>
            + <https://metacpan.org/dist/Devel-TypeCheck>
    * interoperability with machine types
        + <https://metacpan.org/pod/FFI::Platypus::Type>
        + <https://metacpan.org/pod/Glib>, <https://metacpan.org/pod/Glib::Object::Introspection>
        + <https://metacpan.org/pod/PDL::Types>
        + <https://metacpan.org/pod/Inline::Struct>
        + <https://metacpan.org/pod/Convert::Binary::C>
        + <https://metacpan.org/pod/Types::CLike>
            + <https://metacpan.org/pod/MooX::Types::CLike>
        + <https://metacpan.org/pod/Types::Numbers>
        + <https://metacpan.org/pod/Data::Float>
        + <https://metacpan.org/pod/Data::Integer>
        + <https://metacpan.org/pod/Math::Float128>
    * <https://metacpan.org/pod/Types::Algebraic>
    * cperl fork
        + <https://perl11.org/cperl/perltypes.html>
        + <https://perl11.org/cperl/perltypes.html#coretypes>
        + <https://github.com/perl11/cperl/blob/master/pod/perltypes.pod>
        + <https://github.com/perl11/cperl/issues/7>
        + <https://github.com/perl11/cperl/wiki/Type-system>
- Constants
    * <http://neilb.org/reviews/constants.html>
    * <https://metacpan.org/pod/PerlX::Define>
    * <https://metacpan.org/pod/Readonly>
        + <https://metacpan.org/pod/Readonly::BeginLift>
    * <https://metacpan.org/pod/Readonly::Tiny>
    * <https://metacpan.org/pod/ReadonlyX>
    * <https://metacpan.org/pod/Readonly::XS>
    * <https://metacpan.org/pod/Readonly::Enum>
    * <https://metacpan.org/pod/Const::Fast>
        + <https://metacpan.org/pod/Const::Exporter>
    * <https://metacpan.org/pod/Memoize::Lift>
    * <https://metacpan.org/pod/Keyword::Value>
    * <https://metacpan.org/pod/PerlX::Let>
    * <https://metacpan.org/pod/immutable>
- Exception objects
    * <https://metacpan.org/pod/failures>
    * <https://metacpan.org/pod/Exception::Class>
    * <https://metacpan.org/pod/Throwable>
    * <https://metacpan.org/pod/results>
- Enum
    * <https://metacpan.org/pod/enum>
    * <https://metacpan.org/pod/Data::Enum>
- Struct
    * <https://metacpan.org/pod/Struct::Dumb>
    * <https://metacpan.org/pod/MooX::Struct>
- Subroutine tricks (not really new syntax)
    * <https://metacpan.org/pod/PerlX::Maybe>
    * <https://metacpan.org/pod/curry>
    * <https://metacpan.org/pod/Sub::Curry>
    * <https://metacpan.org/pod/Sub::Operable>
    * <https://metacpan.org/pod/Async::Methods>
    * <https://metacpan.org/pod/Object::Util>
    * <https://metacpan.org/pod/Safe::Isa>
    * <https://metacpan.org/pod/Object::Tap>
    * <https://metacpan.org/pod/Try::Chain>
    * Infix operators as subs
        + <https://metacpan.org/pod/Sub::Infix>
    * <https://metacpan.org/pod/Method::Slice>
- methods applied to default object
    * <https://metacpan.org/pod/methods::import>
    * <https://metacpan.org/pod/Object::Import>
    * <https://metacpan.org/pod/with> (deprecated)
    * <https://metacpan.org/pod/Scope::With>
        + depends on <https://metacpan.org/release/CHOCOLATE/mysubs-1.14> (on BackPAN only)
- Changing `goto`: <https://metacpan.org/pod/Goto::Cached>
- Aspect-oriented programming
    * <https://metacpan.org/pod/Aspect>
    * <https://metacpan.org/pod/Class::Method::Modifiers>
- FP
    * <https://metacpan.org/pod/FunctionalPerl>
    * Built-in: <https://metacpan.org/pod/List::Util>
    * <https://metacpan.org/pod/List::AllUtils>
        + <https://metacpan.org/pod/List::SomeUtils>
        + <https://metacpan.org/pod/List::UtilsBy>
    * <https://metacpan.org/pod/List::MoreUtils>
    * <https://hop.perl.plover.com/>
    * <https://metacpan.org/pod/fp>
    * <https://metacpan.org/pod/Perlude>
    * <https://metacpan.org/pod/List::Gen>
    * <https://metacpan.org/pod/Whatever>
    * <https://metacpan.org/pod/HOI::Match>
    * <https://metacpan.org/pod/List::MapMulti>
    * <https://metacpan.org/pod/UnderscoreJS>
    * <https://metacpan.org/pod/Sub::Lambda>
    * <https://metacpan.org/pod/Sub::PatternMatching>
    * <https://metacpan.org/pod/Params::PatternMatch>
    * <https://metacpan.org/pod/Hydrogen>
    * <https://metacpan.org/pod/Function::Composition>
    * <https://metacpan.org/pod/Sub::Fp>
- Logic programming
    * <https://metacpan.org/pod/Logic>
    * <https://metacpan.org/pod/AI::Prolog>
- Destructuring assignment
    * <https://metacpan.org/pod/DestructAssign>
    * <https://metacpan.org/pod/assign>
- Return context
    * <https://metacpan.org/pod/Want>
    * <https://metacpan.org/pod/Context::Handle>
    * <https://metacpan.org/pod/Object::Result>
    * <https://metacpan.org/pod/Array::Slice>
    * <https://metacpan.org/pod/Contextual::Return>
    * <https://metacpan.org/pod/Lvalue>
    * <https://metacpan.org/pod/Acme::Lvalue>
    * <https://metacpan.org/pod/MooX::LvalueAttribute>
    * <https://metacpan.org/pod/LV>
    * <https://metacpan.org/pod/Sub::Lvalue>
    * <https://metacpan.org/pod/Sentinel>
- autoboxing
    * <https://metacpan.org/pod/autobox>
    * <https://metacpan.org/pod/autobox::Core>
- Dispatch table / switch
    * <https://metacpan.org/pod/Switch> (uses source filter)
    * <https://metacpan.org/pod/Switch::Plain> (uses XS keyword)
    * <https://metacpan.org/pod/Switch::Perlish> (uses functions + dynamic scope)
    * <https://metacpan.org/pod/Switch::Reftype> (simple dispatch table, fixed number of cases)
    * <https://metacpan.org/pod/Smart::Dispatch> (uses functions + dynamic scope)
    * <https://metacpan.org/pod/Dispatch::Fu> (uses function prototypes)
    * <https://metacpan.org/pod/Switcheroo> (uses XS keyword via Parse::Keyword)
    * <https://metacpan.org/pod/Dispatch::Declare>
- Safe navigation
    * <https://metacpan.org/pod/PerlX::SafeNav>
        + <https://dev.to/gugod/safe-navigation-monad-4lel>
        + <https://gugod.org/2023/06/perl-safe-navigation-monad-en/>
    * <https://metacpan.org/pod/Scalar::Andand>
- Operator overloading
    * <https://metacpan.org/pod/IO::All>
    * <https://metacpan.org/pod/Package::Relative>
    * <https://metacpan.org/pod/overload::reify>
    * <https://metacpan.org/pod/overload::substr>
- Runtime handling of function calls
    * <https://metacpan.org/pod/Autoload::AUTOCAN>
    * <https://metacpan.org/pod/selfvars::autoload>
        + <https://metacpan.org/pod/selfvars> (uses tie, for OO)
    * <https://metacpan.org/pod/Inline::Java>
    * <https://metacpan.org/pod/Inline::Python>
    * <https://metacpan.org/pod/Tkx>
- <https://metacpan.org/pod/indirect>
    * <https://shadow.cat/blog/matt-s-trout/indirect-but-still-fatal/>
    * <http://blogs.perl.org/users/rurban/2013/02/no-indirect-considered-harmful.html>
- <https://metacpan.org/pod/Rubyish>
    * <https://metacpan.org/pod/PerlX::MethodCallWithBlock>
- <https://metacpan.org/pod/PerlX::ScopeFunction>
- Coroutines
    * <https://metacpan.org/pod/Coro>
- Generators
    * <https://metacpan.org/pod/Compile::Generators> (use `Module::Compile` source filter)
    * Coro-based
        + <https://metacpan.org/pod/Coro::Generator>
        + <https://metacpan.org/pod/Generator::Object>
        + <https://metacpan.org/pod/Attribute::Generator>
- Continuation-passing style
    * <https://metacpan.org/pod/CPS> (deprecated in favour of Future / Future::AsyncAwait)
        + <https://metacpan.org/pod/CPS::Governor::IOAsync>
    * <https://metacpan.org/pod/IO::Lambda>
    * <https://metacpan.org/pod/Async::Chain>
- Tail recursion (keywords to do `goto &sub`)
    * <https://metacpan.org/pod/Sub::Call::Tail>
    * <https://metacpan.org/pod/Sub::Call::Recur>
    * <https://metacpan.org/pod/Keyword::TailRecurse>
- Memoisation
    * <https://metacpan.org/pod/Memoize>
    * <https://metacpan.org/pod/CHI::Memoize>
- Reactive Extensions <https://reactivex.io/>>
    * <https://metacpan.org/pod/RxPerl>
    * <https://metacpan.org/pod/Ryu>
- Communicating sequential processes
    * <https://metacpan.org/pod/Thread::Csp>
- Parallel
    * <https://metacpan.org/pod/Parallel::Map>
- RPC
    * <https://metacpan.org/pod/Object::Remote>
- <https://metacpan.org/pod/Syntax::Keyword::Inplace>

# Extending the parser

- [[LeoNerd's programming thoughts: Writing a Perl Core Feature|https://leonerds-code.blogspot.com/2021/02/writing-perl-core-feature.html]]
- <https://metacpan.org/pod/XS::Parse::Keyword>
    * <https://metacpan.org/pod/XS::Parse::Infix> is not yet available to work in non-patched Perl
    * <https://metacpan.org/pod/XS::Parse::Keyword::FromPerl>
    * <https://metacpan.org/pod/XS::Parse::Sublike>
- Keywords in Pure Perl
    * <https://metacpan.org/pod/Keyword::Simple>
    * <https://metacpan.org/pod/Keyword::Declare>
    * <https://metacpan.org/pod/Keyword::Pluggable> (fork of Keyword::Simple)
    * <https://metacpan.org/pod/Parse::Keyword>
- (deprecated) <https://metacpan.org/pod/Devel::Declare>
- <https://metacpan.org/pod/Devel::CallParser>
- <https://metacpan.org/pod/B::Hooks::Parser>
- <https://metacpan.org/pod/Sub::Op>
- Source filters:
    * <https://metacpan.org/pod/Filter::Simple>
    * <https://metacpan.org/pod/Filter::Util::Call>
    * <https://metacpan.org/dist/Lingua-Romana-Perligata>
        + <https://metacpan.org/dist/Lingua-Romana-Perligata/view/lib/Lingua/Romana/Perligata.pm>
        + <https://users.monash.edu/~damian/papers/HTML/Perligata.html>
    * <https://metacpan.org/pod/Lingua::Sinica::PerlYuYan>
    * <https://metacpan.org/pod/Combinator>
    * <https://metacpan.org/pod/macro>
    * <https://metacpan.org/pod/Macro::Simple>
- Related: `.pmc` files:
    * <https://metacpan.org/pod/Module::Compile>
    * <https://perldoc.perl.org/functions/require>

# Extending the OP tree / interpreter

- <https://metacpan.org/pod/B::C>
- <https://metacpan.org/pod/B::Generate>

Decompilation:
- <https://metacpan.org/pod/B::Deparse>
- [Rocky Bernstein - Where Am I Now A Novel Use Of Decompilation - YouTube](https://www.youtube.com/watch?v=gREriCbwW8E)
    * <https://metacpan.org/pod/B::DeparseTree>
    * [Rocky Bernstein - Decompilation at Runtime and the Design of a Decompiler for Dynamic Interpreted Languages](https://rocky.github.io/Deparsing-Paper.pdf)

- <https://metacpan.org/pod/Opcode>
    * <https://metacpan.org/pod/Safe>
    * <https://metacpan.org/pod/Eval::Safe>
    * <https://metacpan.org/pod/Safe::Hole>
- <https://metacpan.org/pod/overload::eval>

- B::Hooks::
    * <https://metacpan.org/pod/B::Hooks::Parser>
    * <https://metacpan.org/pod/B::Hooks::AtRuntime>
    * <https://metacpan.org/pod/B::Hooks::OP::Check>
    * <https://metacpan.org/pod/B::Hooks::EndOfScope>
    * <https://metacpan.org/pod/B::Hooks::OP::PPAddr>
    * <https://metacpan.org/pod/B::Hooks::OP::Annotation>
    * <https://metacpan.org/pod/B::Hooks::XSUB::CallAsOp>
    * <https://metacpan.org/pod/B::Hooks::OP::Check::LeaveEval>
    * <https://metacpan.org/pod/B::Hooks::OP::Check::StashChange>
    * <https://metacpan.org/pod/B::Hooks::OP::Check::EntersubForCV>

- <https://metacpan.org/pod/Faster>
- <https://metacpan.org/pod/Runops::Optimized>
- <https://metacpan.org/pod/Runops::Switch>
- <http://perlmulticore.schmorp.de/>
    * <https://metacpan.org/pod/Coro::Multicore>

- <https://metacpan.org/pod/Scope::Upper>
    * <https://metacpan.org/pod/return::thence>
    * <https://metacpan.org/pod/Return::MultiLevel>
- <https://metacpan.org/pod/PadWalker>
- <https://metacpan.org/pod/Scope::Escape>

- Attributes
    * <https://metacpan.org/pod/Attribute::Handlers>
    * <https://metacpan.org/pod/decorators>
    * <https://metacpan.org/pod/Exporter::Attributes>
    * <https://metacpan.org/pod/Sub::ArgShortcut>
    * <https://metacpan.org/pod/Sub::Attribute>
- <https://metacpan.org/pod/Sub::WhenBodied>
- <https://metacpan.org/pod/Sub::Mutate>

- <https://metacpan.org/pod/Perl::Phase>

# Changing semantics

- <https://metacpan.org/pod/Variable::Magic>
- <https://metacpan.org/pod/Acme::CPANModules::MagicVariableTechnique>

- <https://metacpan.org/pod/autodie> (in core)
    * <https://metacpan.org/pod/autodie::variables>
- <https://metacpan.org/dist/autovivification>
- <https://metacpan.org/pod/underscore>
- <https://metacpan.org/pod/optimize>
    * has integer optimizations
- Compile time
    * <https://metacpan.org/pod/BEGIN::Lift>
    * <https://metacpan.org/pod/Devel::BeginLift>
- <https://metacpan.org/pod/B::Foreach::Iterator>
- <https://metacpan.org/release/PEVANS/stringification-0.01_004>


# Defer running

- <https://metacpan.org/pod/B::Hooks::EndOfScope>
- <https://metacpan.org/pod/AtExit>
- <https://metacpan.org/pod/Scope::OnExit>
- <https://metacpan.org/pod/Scope::OnExit::Wrap>
- <https://metacpan.org/pod/Scope::Cleanup>
- <https://metacpan.org/pod/Scope::Guard>
- <https://metacpan.org/pod/Guard>
- <https://metacpan.org/pod/End>
- <https://metacpan.org/pod/Perl::AtEndOfScope>
- <https://metacpan.org/pod/ReleaseAction>
- <https://metacpan.org/pod/Scope::local_OnExit>
- <https://metacpan.org/pod/Sub::ScopeFinalizer>
- <https://metacpan.org/pod/Value::Canary>

# Importing into caller

- Imports
    * <https://metacpan.org/pod/Perl::PrereqScanner::NotQuiteLite>
    * <https://metacpan.org/pod/App::perlimports>
- <https://metacpan.org/pod/Import::Into>
- `strict` and more <https://metacpan.org/pod/strictures>
- Miscellaneous that import `strict`:
    * `Modern::Perl`
    * `Mojolicious::Lite`, `Mojo::Base`
    * `Dancer`
    * `Moo`, `Moo::Role`
    * `Test::Most`
    * `Mu`, `Mu::Role`
    * `common::sense`
- `warnings`
    * <https://metacpan.org/pod/warnings::everywhere>
    * <https://metacpan.org/pod/warnings::lock>
    * <https://metacpan.org/pod/warnings::compat>
    * <https://metacpan.org/pod/warnings::method>
    * <https://metacpan.org/pod/warnings::unused>
    * <https://metacpan.org/pod/Warnings::Version>
    * <https://metacpan.org/pod/encoding::warnings>
    * <https://metacpan.org/pod/warnings::pedantic>
    * <https://metacpan.org/pod/warnings::MaybeFatal>
    * <https://metacpan.org/pod/warnings::DynamicScope>
    * <https://metacpan.org/pod/warnings::illegalproto>
    * <https://metacpan.org/pod/warnings::regex::recompile>
- `Syntax::Feature::*`: <https://metacpan.org/pod/syntax>
- <https://metacpan.org/dist/perl5i>
- <https://metacpan.org/pod/new>
- <https://metacpan.org/pod/Acme::Very::Modern::Perl>
- <https://metacpan.org/pod/Acme::CPANModules::ModernPreambles>
- <https://metacpan.org/pod/Dir::Self> (`__DIR__` uses `caller`)
- <https://metacpan.org/pod/Path::This>
- <https://metacpan.org/pod/package::compute>
- <https://metacpan.org/pod/namespace::local>
- Loading modules:
    * Built-in:
        + <https://perldoc.perl.org/Module::Load>
        + <https://perldoc.perl.org/Module::Load::Conditional>
        + <https://metacpan.org/pod/if>
        + <https://metacpan.org/pod/autouse>
        + <https://perldoc.perl.org/AutoLoader>
        + <https://perldoc.perl.org/SelfLoader>
    * <https://metacpan.org/pod/Class::Autouse>
    * <https://metacpan.org/pod/Module::Load::In::INIT>
    * <https://metacpan.org/pod/ClassLoader>
    * <https://metacpan.org/pod/AnyLoader>
    * <https://metacpan.org/pod/Module::Reload>
    * <https://metacpan.org/pod/Module::Runtime>
    * <https://metacpan.org/pod/aliased>
    * <https://metacpan.org/pod/pkg>
    * <https://metacpan.org/pod/Package::Abbreviate>
    * <https://metacpan.org/pod/Module::Reader>
    * <https://metacpan.org/pod/pm>
    * <https://metacpan.org/pod/later>
    * <https://metacpan.org/pod/Module::Quote>
    * <https://metacpan.org/pod/Module::Pluggable>
    * <https://metacpan.org/pod/again>
    * <https://metacpan.org/pod/all>
    * <https://metacpan.org/pod/namespace::alias>
    * Using the network!!!
        + <https://metacpan.org/pod/lib::xi>
        + <https://metacpan.org/pod/lazy>
        + <https://metacpan.org/pod/Acme::Magic::Pony>
    * See also:
        + <https://metacpan.org/pod/Acme::CPANModules::Import::NEILB::ModuleLoading>
- `@INC`
    * <https://metacpan.org/pod/lib::relative>
    * <https://metacpan.org/pod/lib::projectroot>
    * <https://metacpan.org/pod/lib::core::only>
    * <https://metacpan.org/pod/FindBin::libs>
    * <https://metacpan.org/pod/thanks>

# Data structures / Tie

- <https://metacpan.org/pod/Tie::RefHash>
    * <https://metacpan.org/pod/Tie::RefHash::Weak>
- <https://metacpan.org/pod/Tie::ToObject>
- Ordered hash
    * <https://metacpan.org/pod/Hash::Ordered>
    * <https://metacpan.org/pod/Tie::IxHash>

# Parsing / recognising

- See § Parsers at <https://orbital-transfer.github.io/doc/development/language/perl/>
    * <https://www.youtube.com/watch?v=fVnmYzJfy5s>
    * <https://www.youtube.com/watch?v=ob6YHpcXmTg>
- [The Keyword Question · Issue #273 · Perl-Critic/PPI · GitHub](https://github.com/Perl-Critic/PPI/issues/273)
- [Perl Cannot Be Parsed: A Formal Proof](https://perlmonks.org/?node_id=663393)
    * <https://jeffreykegler.github.io/personal/undecide/TPR1.pdf>
    * <https://jeffreykegler.github.io/personal/undecide/TPR2.pdf>
    * <https://jeffreykegler.github.io/personal/undecide/TPR3.pdf>
- https://perl.plover.com/NPC/
- [[perlapi - Lexer interface|https://perldoc.perl.org/perlapi#Lexer-interface]]
    * <https://metacpan.org/pod/Perl::Lexer>

# Design patterns

- <http://savannah.nongnu.org/projects/perlpatbook/>
    * <https://metacpan.org/release/SWALTERS/Object-PerlDesignPatterns-0.03/view/PerlDesignPatterns.pm>
    * <http://backpan.perl.org/authors/id/S/SW/SWALTERS/Perl_Design_Patterns_book_20021008.html>
    * <https://web.archive.org/web/20170305195947/http://www.perldesignpatterns.com/>
    * <https://web.archive.org/web/20031202213732/http://wiki.slowass.net:80/?PerlDesignPatterns>
    * <https://wiki.c2.com/?PerlPatternsRepository>
    * <https://en.wikipedia.org/wiki/Perl_Design_Patterns_Book>
    * Powered by <https://github.com/scrottie/TinyWiki>
- <https://github.com/manwar/Design-Patterns>
- <https://www.perl.com/pub/2003/06/13/design1.html/>
- <https://github.com/jeffa/DesignPatterns-Perl>
- <https://github.com/ynonp/perl-design-patterns>
- Dependency injection
    * <https://metacpan.org/pod/Bread::Board>
    * <https://metacpan.org/pod/Rewire>
    * <https://metacpan.org/pod/Class::DI>
    * <https://metacpan.org/pod/Beam::Wire>
    * <https://metacpan.org/pod/IOC>
- "named args"
    * <https://metacpan.org/pod/PerlX::ArraySkip>
