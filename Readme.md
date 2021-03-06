UncommEnter
===========

UncommEnter lets you end a comment series caused by formatoption `r` by
simply hitting <kbd>Enter</kbd> on the last empty line of a comment.

For more information on usage, options and license, see UncommEnter.txt
or type `:help UncommEnter` inside Vim.

http://github.com/padde/UncommEnter.vim


Installation
------------

*Pathogen*

```sh
cd ~/.vim/bundle
git clone git://github.com/padde/UncommEnter.vim.git
```

*Vundle*

add this line to your `~/.vimrc`:

```viml
Bundle 'padde/UncommEnter.vim'
```



Examples (Ruby)
---------------

In the following examples, `|` represents the cursor.

```ruby
# this is a comment|
```

hit <kbd>Enter</kbd>

```ruby
# this is a comment
# |
```

hit <kbd>Enter</kbd> again

```ruby
# this is a comment
|
```

This means you don't have to type <kbd>Esc</kbd>+<kbd>⇧</kbd>+<kbd>S</kbd>
or <kbd>Ctrl</kbd>+<kbd>U</kbd> any more. UncommEnter is smart enough to not
fiddle around with comments when you're in the middle of a multi-line comment
like this one:

```ruby
# this is a comment|
# that spans multiple lines
```

hit <kbd>Enter</kbd>

```ruby
# this is a comment
# |
# that spans multiple lines
```

hit <kbd>Enter</kbd> again

```ruby
# this is a comment
#
# |
# that spans multiple lines
```

The tradeoff is that if you actually want multiple empty comment lines,
you have to re-add one line manually:

```ruby
# this is a comment|
```

hit <kbd>Enter</kbd>

```ruby
# this is a comment
# |
```

hit <kbd>Esc</kbd>o

```ruby
# this is a comment
#
# |
```

UncommEnter will however not delete the comment marker if the previous
line is also just an empty comment. That means for successive empty
comment lines, you can just hit <kbd>Enter</kbd> as normal:

```ruby
# this is a comment
#
# |
```

hit <kbd>Enter</kbd> twice

```ruby
# this is a comment
#
#
#
# |
```


To do
-----

UncommEnter currently uses `&commentstring` to determine whether the
current line is an empty comment or not. This has only one form of the
comment marker for languages like C. Unfortunately, this seems to be
the multiline form (e.g. `/*  */`) most of the time. This means that
UncommEnter will not work properly in those languages. However, it does
not break existing behaviour, it will just not end the comment as
advertised.


Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
