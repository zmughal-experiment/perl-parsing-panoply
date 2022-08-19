# Syntax added in core Perl

- <https://metacpan.org/pod/feature>
- <https://metacpan.org/pod/B::Keywords>
- "Secret" combinations of operators: <https://metacpan.org/dist/perlsecret>
- <https://metacpan.org/pod/Syntax::Construct>
- Fallbacks to backport features:
    * `try`/`catch`: <https://metacpan.org/pod/Feature::Compat::Try>
    * `defer`: <https://metacpan.org/pod/Feature::Compat::Defer>
    * `builtin`: <https://metacpan.org/pod/builtins::compat>
    * `say`: <https://metacpan.org/pod/Say::Compat>, <https://metacpan.org/pod/say>

# Syntax extensions on CPAN

The following are various ways of extending the syntax. They might be
implemented as simple subroutine calls (e.g., used inline like `Try::Tiny`,
used as declarative code generators like `Moo`). They might be implemented as
source filters. They might use attributes. They might hook into the parser and
change how the code is interpreted. They might be implemented as keywords.

- `try`/`catch`
    * XS keyword plugin: <https://metacpan.org/pod/Syntax::Keyword::Try>
    * subs: <https://metacpan.org/pod/Try::Tiny>
    * <https://metacpan.org/pod/TryCatch> (uses Devel::Declare)
    * XS keyword plugin: <https://metacpan.org/pod/Syntax::Feature::Try>
    * <https://metacpan.org/pod/Try> (uses Devel::CallParser + Try::Tiny)
- `async`/`await`
    * XS keyword plugin: <https://metacpan.org/pod/Future::AsyncAwait>
    * PPR-based source filter: <https://metacpan.org/pod/PerlX::AsyncAwait>
- signatures + parameters
    * XS keyword plugin: <https://metacpan.org/pod/Function::Parameters>
    * <https://metacpan.org/pod/Method::Signatures> (uses Devel::Declare)
    * <https://metacpan.org/pod/Method::Signatures::Simple> (uses Devel::Declare)
    * <https://metacpan.org/pod/Smart::Args>
        + <https://metacpan.org/pod/Smart::Args::TypeTiny>
    * PPR-based source filter: <https://metacpan.org/pod/Method::Signatures::PP>
    * <https://metacpan.org/pod/signatures> (uses B::Hooks::Parser)
- multiple dispatch
    * XS keyword plugin: <https://metacpan.org/pod/Syntax::Keyword::MultiSub>
    * attributes: <https://metacpan.org/pod/Sub::Multi::Tiny>
    * <https://metacpan.org/pod/Class::Multimethods>
        + <https://www.foo.be/docs/tpj/issues/vol5_1/tpj0501-0010.html>
    * <https://metacpan.org/pod/Sub::MultiMethod>
    * <https://metacpan.org/pod/Sub::SymMethod>
- `defer`
    * XS keyword plugin: <https://metacpan.org/pod/Syntax::Keyword::Defer>
- OO
    * <https://metacpan.org/pod/Object::Pad>
    * <https://metacpan.org/pod/Moops>
    * <https://metacpan.org/pod/Zydeco>
    * <https://metacpan.org/pod/Dios>
        + and multiple dispatch
    * <https://metacpan.org/pod/Class::Struct>
    * <https://metacpan.org/pod/Mic>
    * <https://metacpan.org/pod/Mite>
    * Moose, Mouse, Moo, Mo, Mu, Role::Tiny, Class::Tiny
        + <https://metacpan.org/dist/MooseX-MungeHas>
        + <https://metacpan.org/pod/Sub::HandlesVia>
        + <https://metacpan.org/pod/CLI::Osprey>
        + <https://metacpan.org/pod/MooX::Should>
    * method resolution
        + <https://metacpan.org/pod/MRO::Compat>
        + <https://metacpan.org/pod/Class::C3>
        + <https://metacpan.org/pod/MRO::Magic>
        + <https://metacpan.org/pod/subs::auto>
        + <https://metacpan.org/pod/NEXT>
        + <https://metacpan.org/pod/next::XS>
        + <https://metacpan.org/pod/CLASS>
        + <https://metacpan.org/pod/SUPER>
    * <https://metacpan.org/pod/Object::Extend>
- Operators
    * Smart-match
        + <https://metacpan.org/pod/match::smart>
        + <https://metacpan.org/pod/match::simple>
        + <https://metacpan.org/pod/Syntax::Feature::In>
    * `isa`
        + <https://metacpan.org/pod/isa>
- Types
    * syntax
        + attributes: <https://metacpan.org/pod/Attribute::Types>
        + tied variables: <https://metacpan.org/pod/Type::Tie>
        + magic: <https://metacpan.org/pod/Lexical::TypeTiny> (uses Variable::Magic)
        + <https://metacpan.org/pod/Variable::Declaration> (uses Keyword::Simple + Type::Tie)
    * checking / constraints
        + <https://metacpan.org/pod/Type::Tiny>
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
- Constants
    * <https://metacpan.org/pod/PerlX::Define>
    * <https://metacpan.org/pod/Readonly>
    * <https://metacpan.org/pod/Const::Fast>
        + <https://metacpan.org/pod/Const::Exporter>
- Exception objects
    * <https://metacpan.org/pod/failures>
    * <https://metacpan.org/pod/Exception::Class>
    * <https://metacpan.org/pod/Throwable>
- Enum
    * <https://metacpan.org/pod/enum>
- Struct
    * <https://metacpan.org/pod/Struct::Dumb>
    * <https://metacpan.org/pod/MooX::Struct>
- Subroutine tricks (not really new syntax)
    * <https://metacpan.org/pod/PerlX::Maybe>
    * <https://metacpan.org/pod/curry>
    * <https://metacpan.org/pod/Sub::Operable>
    * <https://metacpan.org/pod/Async::Methods>
    * <https://metacpan.org/pod/Object::Util>
    * <https://metacpan.org/pod/Safe::Isa>
    * <https://metacpan.org/pod/Object::Tap>
    * <https://metacpan.org/pod/Try::Chain>
    * Infix operators as subs
        + <https://metacpan.org/pod/Sub::Infix>
    * <https://metacpan.org/pod/Method::Slice>
