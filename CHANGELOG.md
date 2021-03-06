## 5.0.0 (Unreleased)

### Breaking Changes

- [#556](https://github.com/airblade/paper_trail/pull/556) /
  [#301](https://github.com/airblade/paper_trail/issues/301) -
  If you are tracking who is responsible for changes with `whodunnit`, be aware
  that PaperTrail no longer adds the `set_paper_trail_whodunnit` before_filter
  for you. Please add this before_filter to your ApplicationController to
  continue recording whodunnit. See the readme for an example.

### Added

None

### Fixed

None

## 4.1.0 (Unreleased)

### Breaking Changes

- None

### Added

- A way to control the order of AR callbacks.
  [#614](https://github.com/airblade/paper_trail/pull/614)
- Added `unversioned_attributes` option to `reify`.
  [#579](https://github.com/airblade/paper_trail/pull/579)

### Fixed

- None

## 4.0.1

### Breaking Changes

- None

### Added

- None

### Fixed

- [#636](https://github.com/airblade/paper_trail/issues/636) -
  Should compile assets without a db connection
- [#589](https://github.com/airblade/paper_trail/pull/589) /
  [#588](https://github.com/airblade/paper_trail/issues/588) -
  Fixes timestamp for "create" versions

## 4.0.0

This major release adds JSON column support in PostgreSQL, limited support for
versioning associations, various new configuration options, and a year's worth
of bug fixes. Thanks to everyone who helped test the two betas and two release
candidates.

### Breaking Changes

- Using a Rails initializer to reopen PaperTrail::Version or otherwise extend
  PaperTrail is no longer recommended. An alternative is described in the
  readme. See https://github.com/airblade/paper_trail/pull/557 and
  https://github.com/airblade/paper_trail/pull/492.
- If you depend on the `RSpec` or `Cucumber` helpers, you must
  [require them in your test helper](https://github.com/airblade/paper_trail#testing).
- [#566](https://github.com/airblade/paper_trail/pull/566) - Removed deprecated
  methods `paper_trail_on` and `paper_trail_off`. Use `paper_trail_on!` and
  `paper_trail_off!` instead.
- [#458](https://github.com/airblade/paper_trail/pull/458) - Version metadata
  (the `:meta` option) from AR attributes for `create` events will now save the
  current value instead of `nil`.
- [#391](https://github.com/airblade/paper_trail/issues/391) - `object_changes`
  value should dump to `YAML` as a normal `Hash` instead of an
  `ActiveSupport::HashWithIndifferentAccess`.
- [#375](https://github.com/airblade/paper_trail/pull/375) /
  [#374](https://github.com/airblade/paper_trail/issues/374) /
  [#354](https://github.com/airblade/paper_trail/issues/354) /
  [#131](https://github.com/airblade/paper_trail/issues/131) -
  Versions are now saved with an `after_` callback, instead of a `before_`
  callback. This ensures that the timestamp field for a version matches the
  corresponding timestamp in the model.
- `3da1f104` - `PaperTrail.config` and `PaperTrail.configure` are now
  identical: both return the `PaperTrail::Config` instance and also
  yield it if a block is provided.

### Added

- [#525](https://github.com/airblade/paper_trail/issues/525) /
  [#512](https://github.com/airblade/paper_trail/pull/512) -
  Support for virtual accessors and redefined setter and getter methods.
- [#518](https://github.com/airblade/paper_trail/pull/518) - Support for
  querying against PostgreSQL's
  [`JSON` and `JSONB` column types](http://www.postgresql.org/docs/9.4/static/datatype-json.html)
  via `PaperTrail::VersionConcern#where_object` and
  `PaperTrail::VersionConcern#where_object_changes`
- [#507](https://github.com/airblade/paper_trail/pull/507) -
  New option: `:save_changes` controls whether or not to save changes to the
  `object_changes` column (if it exists).
- [#500](https://github.com/airblade/paper_trail/pull/500) - Support for
  passing an empty array to the `on` option (`on: []`) to disable all
  automatic versioning.
- [#494](https://github.com/airblade/paper_trail/issues/494) - The install
  generator will warn the user if the migration they are attempting to
  generate already exists.
- [#484](https://github.com/airblade/paper_trail/pull/484) - Support for
  [PostgreSQL's `JSONB` Type](http://www.postgresql.org/docs/9.4/static/datatype-json.html)
  for storing `object` and `object_changes`.
- [#439](https://github.com/airblade/paper_trail/pull/439) /
  [#12](https://github.com/airblade/paper_trail/issues/12) -
  Support for versioning associations (has many, has one, etc.) one level deep.
- [#420](https://github.com/airblade/paper_trail/issues/420) - Add
  `VersionConcern#where_object_changes` instance method; acts as a helper for
  querying against the `object_changes` column in versions table.
- [#416](https://github.com/airblade/paper_trail/issues/416) - Added a
  `config` option for enabling/disabling utilization of
  `serialized_attributes` for `ActiveRecord`, necessary because
  `serialized_attributes` has been deprecated in `ActiveRecord` version `4.2`
  and will be removed in version `5.0`
- [#399](https://github.com/airblade/paper_trail/pull/399) - Add `:dup`
  argument for options hash to `reify` which forces a new model instance.
- [#394](https://github.com/airblade/paper_trail/pull/394) - Add RSpec matcher
  `have_a_version_with` for easier testing.
- [#347](https://github.com/airblade/paper_trail/pull/347) - Autoload
  `ActiveRecord` models in via a `Rails::Engine` when the gem is used with
  `Rails`.

### Fixed

- [#563](https://github.com/airblade/paper_trail/pull/563) - Fixed a bug in
  `touch_with_version` so that it will still create a version even when the
  `on` option is, e.g. `[:create]`.
- [#541](https://github.com/airblade/paper_trail/pull/541) -
  `PaperTrail.config.enabled` should be Thread Safe
- [#451](https://github.com/airblade/paper_trail/issues/451) - Fix `reify`
  method in context of model where the base class has a default scope, and the
  live instance is not scoped within that default scope.
- [#440](https://github.com/airblade/paper_trail/pull/440) - `versions`
  association should clear/reload after a transaction rollback.
- [#438](https://github.com/airblade/paper_trail/issues/438) -
  `ModelKlass.paper_trail_enabled_for_model?` should return `false` if
  `has_paper_trail` has not been declared on the class.
- [#404](https://github.com/airblade/paper_trail/issues/404) /
  [#428](https://github.com/airblade/paper_trail/issues/428) -
  `model_instance.dup` does not need to be invoked when examining what the
  instance looked like before changes were persisted, which avoids issues if a
  3rd party has overriden the `dup` behavior. Also fixes errors occuring when
  a user attempts to update the inheritance column on an STI model instance in
  `ActiveRecord` 4.1.x
- [#427](https://github.com/airblade/paper_trail/pull/427) - Fix `reify`
  method in context of model where a column has been removed.
- [#414](https://github.com/airblade/paper_trail/issues/414) - Fix
  functionality `ignore` argument to `has_paper_trail` in `ActiveRecord` 4.
- [#413](https://github.com/airblade/paper_trail/issues/413) - Utilize
  [RequestStore](https://github.com/steveklabnik/request_store) to ensure that
  the `PaperTrail.whodunnit` is set in a thread safe manner within Rails and
  Sinatra.
- [#381](https://github.com/airblade/paper_trail/issues/381) - Fix `irb`
  warning: `can't alias context from irb_context`. `Rspec` and `Cucumber`
  helpers should not be loaded by default, regardless of whether those
  libraries are loaded.
- [#248](https://github.com/airblade/paper_trail/issues/248) - In MySQL, to
  prevent truncation, generated migrations now use `longtext` instead of `text`.
- Methods handling serialized attributes should fallback to the currently set
  Serializer instead of always falling back to `PaperTrail::Serializers::YAML`.

### Deprecated

- [#479](https://github.com/airblade/paper_trail/issues/479) - Deprecated
  `originator` method, use `paper_trail_originator`.

## 3.0.9

  - [#479](https://github.com/airblade/paper_trail/issues/479) - Deprecated
    `originator` method in favor of `paper_trail_originator` Deprecation warning
    informs users that the `originator` of the methods will be removed in
    version `4.0`. (Backported from v4)
  - Updated deprecation warnings for `Model.paper_trail_on` and
    `Model.paper_trail_off` to have display correct version number the methods
    will be removed (`4.0`)

## 3.0.8

  - [#525](https://github.com/airblade/paper_trail/issues/525) / [#512](https://github.com/airblade/paper_trail/pull/512) -
    Support for virtual accessors and redefined setter and getter methods.

## 3.0.7

  - [#404](https://github.com/airblade/paper_trail/issues/404) / [#428](https://github.com/airblade/paper_trail/issues/428) -
    Fix errors occuring when a user attempts to update the inheritance column on an STI model instance in `ActiveRecord` 4.1.x

## 3.0.6

  - [#414](https://github.com/airblade/paper_trail/issues/414) - Backport fix for `ignore` argument to `has_paper_trail` in
    `ActiveRecord` 4.

## 3.0.5

  - [#401](https://github.com/airblade/paper_trail/issues/401) / [#406](https://github.com/airblade/paper_trail/issues/406) -
    `PaperTrail::Version` class is not loaded via a `Rails::Engine`, even when the gem is used with in Rails. This feature has
    will be re-introduced in version `4.0`.
  - [#398](https://github.com/airblade/paper_trail/pull/398) - Only require the `RSpec` helper if `RSpec::Core` is required.

## 3.0.3
*This version was yanked from RubyGems and has been replaced by version `3.0.5`, which is almost identical, but does not eager load
in the `PaperTrail::Version` class through a `Rails::Engine` when the gem is used on Rails since it was causing issues for some users.*

  - [#386](https://github.com/airblade/paper_trail/issues/386) - Fix eager loading of `versions` association with custom class name
    in `ActiveRecord` 4.1.
  - [#384](https://github.com/airblade/paper_trail/issues/384) - Fix `VersionConcern#originator` instance method.
  - [#383](https://github.com/airblade/paper_trail/pull/383) - Make gem compatible with `ActiveRecord::Enum` (available in `ActiveRecord` 4.1+).
  - [#380](https://github.com/airblade/paper_trail/pull/380) / [#377](https://github.com/airblade/paper_trail/issues/377) -
    Add `VersionConcern#where_object` instance method; acts as a helper for querying against the `object` column in versions table.
  - [#373](https://github.com/airblade/paper_trail/pull/373) - Fix default sort order for the `versions` association in `ActiveRecord` 4.1.
  - [#372](https://github.com/airblade/paper_trail/pull/372) - Use [Arel](https://github.com/rails/arel) for SQL construction.
  - [#365](https://github.com/airblade/paper_trail/issues/365) - `VersionConcern#version_at` should return `nil` when receiving a timestamp
    that occured after the object was destroyed.
  - Expand `PaperTrail::VERSION` into a module, mimicking the form used by Rails to give it some additional modularity & versatility.
  - Fixed `VersionConcern#index` instance method so that it conforms to using the primary key for ordering when possible.

## 3.0.2

  - [#357](https://github.com/airblade/paper_trail/issues/357) - If a `Version` instance is reified and then persisted at that state,
    it's timestamp attributes for update should still get `touch`ed.
  - [#351](https://github.com/airblade/paper_trail/pull/351) / [#352](https://github.com/airblade/paper_trail/pull/352) -
    `PaperTrail::Rails::Controller` should hook into all controller types, and should not get loaded unless `ActionController` is.
  - [#346](https://github.com/airblade/paper_trail/pull/346) - `user_for_paper_trail` method should accommodate different types
    for return values from `current_user` method.
  - [#344](https://github.com/airblade/paper_trail/pull/344) - Gem is now tested against `MySQL` and `PostgreSQL` in addition to `SQLite`.
  - [#317](https://github.com/airblade/paper_trail/issues/317) / [#314](https://github.com/airblade/paper_trail/issues/314) -
    `versions` should default to ordering via the primary key if it is an integer to avoid timestamp comparison issues.
  - `PaperTrail::Cleaner.clean_versions!` should group versions by `PaperTrail.timestamp_field` when deciding which ones to
    keep / destroy, instead of always grouping by the `created_at` field.
  - If a `Version` instance is reified and then persisted at that state, it's source version
    (`model_instance#version_association_name`, usually `model_instance#version`) will get cleared since persisting it causes it to
    become the live instance.
  - If `destroy` actions are tracked for a versioned model, invoking `destroy` on the model will cause the corresponding version that
    gets generated to be assigned as the source version (`model_instance#version_association_name`, usually `model_instance#version`).

## 3.0.1

  - [#340](https://github.com/airblade/paper_trail/issues/340) - Prevent potential error encountered when using the `InstallGenerator`
    with Rails `4.1.0.rc1`.
  - [#334](https://github.com/airblade/paper_trail/pull/334) - Add small-scope `whodunnit` method to `PaperTrail::Model::InstanceMethods`.
  - [#329](https://github.com/airblade/paper_trail/issues/329) - Add `touch_with_version` method to `PaperTrail::Model::InstanceMethods`,
    to allow for generating a version while `touch`ing a model.
  - [#328](https://github.com/airblade/paper_trail/pull/328) / [#326](https://github.com/airblade/paper_trail/issues/326) /
    [#307](https://github.com/airblade/paper_trail/issues/307) - `Model.paper_trail_enabled_for_model?` and
    `model_instance.without_versioning` is now thread-safe.
  - [#316](https://github.com/airblade/paper_trail/issues/316) - `user_for_paper_trail` should default to `current_user.try(:id)`
    instead of `current_user` (if `current_user` is defined).
  - [#313](https://github.com/airblade/paper_trail/pull/313) - Make the `Rails::Controller` helper compatible with
    `ActionController::API` for compatibility with the [`rails-api`](https://github.com/rails-api/rails-api) gem.
  - [#312](https://github.com/airblade/paper_trail/issues/312) - Fix RSpec `with_versioning` class level helper method.
  - `model_instance.without_versioning` now yields the `model_instance`, enabling syntax like this:
    `model_instance.without_versioning { |obj| obj.update_attributes(:name => 'value') }`.
  - Deprecated `Model.paper_trail_on` and `Model.paper_trail_off` in favor of bang versions of the methods.
    Deprecation warning informs users that the non-bang versions of the methods will be removed in version `4.0`

## 3.0.0

  - [#305](https://github.com/airblade/paper_trail/pull/305) - `PaperTrail::VERSION` should be loaded at runtime.
  - [#295](https://github.com/airblade/paper_trail/issues/295) - Explicitly specify table name for version class when
    querying attributes. Prevents `AmbiguousColumn` errors on certain `JOIN` statements.
  - [#289](https://github.com/airblade/paper_trail/pull/289) - Use `ActiveSupport::Concern` for implementation of base functionality on
    `PaperTrail::Version` class. Increases flexibility and makes it easier to use custom version classes with multiple `ActiveRecord` connections.
  - [#288](https://github.com/airblade/paper_trail/issues/288) - Change all scope declarations to class methods on the `PaperTrail::Version`
    class. Fixes usability when `PaperTrail::Version.abstract_class? == true`.
  - [#287](https://github.com/airblade/paper_trail/issues/287) - Support for
    [PostgreSQL's JSON Type](http://www.postgresql.org/docs/9.2/static/datatype-json.html) for storing `object` and `object_changes`.
  - [#281](https://github.com/airblade/paper_trail/issues/281) - `Rails::Controller` helper will return `false` for the
    `paper_trail_enabled_for_controller` method if `PaperTrail.enabled? == false`.
  - [#280](https://github.com/airblade/paper_trail/pull/280) - Don't track virtual timestamp attributes.
  - [#278](https://github.com/airblade/paper_trail/issues/278) / [#272](https://github.com/airblade/paper_trail/issues/272) -
    Make RSpec and Cucumber helpers usable with [Spork](https://github.com/sporkrb/spork) and [Zeus](https://github.com/burke/zeus).
  - [#273](https://github.com/airblade/paper_trail/pull/273) - Make the `only` and `ignore` options accept `Hash` arguments;
    allows for conditional tracking.
  - [#264](https://github.com/airblade/paper_trail/pull/264) - Allow unwrapped symbol to be passed in to the `on` option.
  - [#224](https://github.com/airblade/paper_trail/issues/224)/[#236](https://github.com/airblade/paper_trail/pull/236) -
    Fixed compatibility with [ActsAsTaggableOn](https://github.com/mbleigh/acts-as-taggable-on).
  - [#235](https://github.com/airblade/paper_trail/pull/235) - Dropped unnecessary secondary sort on `versions` association.
  - [#216](https://github.com/airblade/paper_trail/pull/216) - Added helper & extension for [RSpec](https://github.com/rspec/rspec),
    and helper for [Cucumber](http://cukes.info).
  - [#212](https://github.com/airblade/paper_trail/pull/212) - Added `PaperTrail::Cleaner` module, useful for discarding draft versions.
  - [#207](https://github.com/airblade/paper_trail/issues/207) - Versions for `'create'` events are now created with `create!` instead of
    `create` so that an exception gets raised if it is appropriate to do so.
  - [#199](https://github.com/airblade/paper_trail/pull/199) - Rails 4 compatibility.
  - [#165](https://github.com/airblade/paper_trail/pull/165) - Namespaced the `Version` class under the `PaperTrail` module.
  - [#119](https://github.com/airblade/paper_trail/issues/119) - Support for [Sinatra](http://www.sinatrarb.com/); decoupled gem from `Rails`.
  - Renamed the default serializers from `PaperTrail::Serializers::Yaml` and `PaperTrail::Serializers::Json` to the capitalized forms,
    `PaperTrail::Serializers::YAML` and `PaperTrail::Serializers::JSON`.
  - Removed deprecated `set_whodunnit` method from Rails Controller scope.

## 2.7.2

  - [#228](https://github.com/airblade/paper_trail/issues/228) - Refactored default `user_for_paper_trail` method implementation
    so that `current_user` only gets invoked if it is defined.
  - [#219](https://github.com/airblade/paper_trail/pull/219) - Fixed issue where attributes stored with `nil` value might not get
    reified properly depending on the way the serializer worked.
  - [#213](https://github.com/airblade/paper_trail/issues/213) - Added a `version_limit` option to the `PaperTrail::Config` options
    that can be used to restrict the number of versions PaperTrail will store per object instance.
  - [#187](https://github.com/airblade/paper_trail/pull/187) - Confirmed JRuby support.
  - [#174](https://github.com/airblade/paper_trail/pull/174) - The `event` field on the versions table can now be customized.

## 2.7.1

  - [#206](https://github.com/airblade/paper_trail/issues/206) - Fixed Ruby 1.8.7 compatibility for tracking `object_changes`.
  - [#200](https://github.com/airblade/paper_trail/issues/200) - Fixed `next_version` method so that it returns the live model
    when called on latest reified version of a model prior to the live model.
  - [#197](https://github.com/airblade/paper_trail/issues/197) - PaperTrail now falls back on using YAML for serialization of
    serialized model attributes for storage in the `object` and `object_changes` columns in the `Version` table. This fixes
    compatibility for `Rails 3.0.x` for projects that employ the `serialize` declaration on a model.
  - [#194](https://github.com/airblade/paper_trail/issues/194) - A JSON serializer is now included in the gem.
  - [#192](https://github.com/airblade/paper_trail/pull/192) - `object_changes` should store serialized representation of serialized
    attributes for `create` actions (in addition to `update` actions, which had already been patched by
    [#180](https://github.com/airblade/paper_trail/pull/180)).
  - [#190](https://github.com/airblade/paper_trail/pull/190) - Fixed compatibility with
    [SerializedAttributes](https://github.com/technoweenie/serialized_attributes) gem.
  - [#189](https://github.com/airblade/paper_trail/pull/189) - Provided support for a `configure` block initializer.
  - Added `setter` method for the `serializer` config option.

## 2.7.0

  - [#183](https://github.com/airblade/paper_trail/pull/183) - Fully qualify the `Version` class to help prevent
    namespace resolution errors within other gems / plugins.
  - [#180](https://github.com/airblade/paper_trail/pull/180) - Store serialized representation of serialized attributes
    on the `object` and `object_changes` columns in the `Version` table.
  - [#164](https://github.com/airblade/paper_trail/pull/164) - Allow usage of custom serializer for storage of object attributes.

## 2.6.4

  - [#181](https://github.com/airblade/paper_trail/issues/181)/[#182](https://github.com/airblade/paper_trail/pull/182) -
    Controller metadata methods should only be evaluated when `paper_trail_enabled_for_controller == true`.
  - [#177](https://github.com/airblade/paper_trail/issues/177)/[#178](https://github.com/airblade/paper_trail/pull/178) -
    Factored out `version_key` into it's own method to prevent `ConnectionNotEstablished` error from getting thrown in
    instances where `has_paper_trail` is declared on class prior to ActiveRecord establishing a connection.
  - [#176](https://github.com/airblade/paper_trail/pull/176) - Force metadata calls for attributes to use current value
    if attribute value is changing.
  - [#173](https://github.com/airblade/paper_trail/pull/173) - Update link to [diff-lcs](https://github.com/halostatue/diff-lcs).
  - [#172](https://github.com/airblade/paper_trail/pull/172) - Save `object_changes` on creation.
  - [#168](https://github.com/airblade/paper_trail/pull/168) - Respect conditional `:if` or `:unless` arguments to the
    `has_paper_trail` method for `destroy` events.
  - [#167](https://github.com/airblade/paper_trail/pull/167) - Fix `originator` method so that it works with subclasses and STI.
  - [#160](https://github.com/airblade/paper_trail/pull/160) - Fixed failing tests and resolved out of date dependency issues.
  - [#157](https://github.com/airblade/paper_trail/pull/157) - Refactored `class_attribute` names on the `ClassMethods` module
    for names that are not obviously pertaining to PaperTrail to prevent method name collision.
