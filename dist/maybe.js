/* Maybe v0.0.1 */
/*
  Eliminates the need for conditionals when retrieving properties from an object.
  Insprired by the Maybe Monad and this article:
  http://flippinawesome.org/2013/10/28/a-gentle-introduction-to-monads-in-javascript/
*/


(function() {
  var Nothing,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Maybe = (function() {
    /*
      Construct a new Maybe using the specified value.
    */

    function Maybe(value) {
      this.value = value;
    }

    /*
      Invokes specified callback when a value does not exist.
    */


    Maybe.prototype.error = function(cb) {
      return this;
    };

    /*
      Invokes specified callback when a value exists.
    */


    Maybe.prototype.then = function(cb) {
      cb(this.value);
      return this;
    };

    /*
      Returns the value of the specified property as a new Maybe.
    */


    Maybe.prototype.has = function(property, defaultValue) {
      var _ref;
      if (defaultValue == null) {
        defaultValue = null;
      }
      if (((_ref = this.value) != null ? _ref[property] : void 0) == null) {
        return new Nothing(defaultValue);
      }
      return new Maybe(this.value[property]);
    };

    /*
      Returns the value of the Maybe.
    */


    Maybe.prototype.getValue = function() {
      return this.value;
    };

    return Maybe;

  })();

  /*
    Represents the absence of a property. Although nothing can still hold a value,
    this happens when the user specifies a default value.
  */


  Nothing = (function(_super) {
    __extends(Nothing, _super);

    /*
      Construct a new Maybe that represents Nothing - optionally taking a value.
    */


    function Nothing(value) {
      if (value == null) {
        value = null;
      }
      Nothing.__super__.constructor.call(this, value);
    }

    /*
      Invokes specified callback when a value does not exist.
    */


    Nothing.prototype.error = function(cb) {
      cb();
      return this;
    };

    /*
      Invokes specified callback when a value exists.  However, because this class represents
      Nothing the callback is never invoked - instead the error callback is invoked.
    */


    Nothing.prototype.then = function() {
      return this;
    };

    /*
      Returns the value of the Maybe.  In this case this Maybe represents Nothing, and so we
      throw a new Exception unless the user has provided a default value, in which case we
      return the default value instead.
    */


    Nothing.prototype.getValue = function() {
      if (this.value != null) {
        return this.value;
      } else {
        throw Error('Nothing does not have a value');
      }
    };

    return Nothing;

  })(window.Maybe);

}).call(this);
