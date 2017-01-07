module Colorless.CodeGen.Types
  (
  ) where

import Pregame

newtype FuncName = FuncName Text deriving (Show, Eq, Ord, IsString)
newtype ArgName = ArgName Text deriving (Show, Eq, Ord, IsString)
newtype Tag = Tag Text deriving (Show, Eq, Ord, IsString)
newtype SumName = SumName Text deriving (Show, Eq, Ord, IsString)
newtype SubtypeName = SubtypeName Text deriving (Show, Eq, Ord, IsString)
newtype FieldName = FieldName Text deriving (Show, Eq, Ord, IsString)
newtype OpaqueName = OpaqueName Text deriving (Show, Eq, Ord, IsString)
newtype TypeParamName = TypeParamName Text deriving (Show, Eq, Ord, IsString)
newtype Negative = Negative Integer deriving (Show, Eq, Num)
newtype Positive = Positive Integer deriving (Show, Eq, Num)
newtype Natural = Natural Integer deriving (Show, Eq, Num)
newtype Rational = Rational (Integer, Integer) deriving (Show, Eq)
newtype Version = Version (Integer, Integer, Integer) deriving (Show, Eq, Ord)
newtype HttpDirectory = HttpDirectory [Text] deriving (Show, Eq, Monoid)
newtype HttpPort = HttpPort Int deriving (Show, Eq)
newtype SpecName = SpecName Text deriving (Show, Eq, IsString)
newtype DomainName = DomainName Text deriving (Show, Eq, IsString)

data PrimType
  = PrimTypeUnit
  | PrimTypeU8
  | PrimTypeU16
  | PrimTypeU32
  | PrimTypeU64
  | PrimTypeI8
  | PrimTypeI16
  | PrimTypeI32
  | PrimTypeI64
  | PrimTypeF32
  | PrimTypeF64
  | PrimTypeBool
  | PrimTypeChar
  | PrimTypeStr
  | PrimTypeInt
  | PrimTypeNeg
  | PrimTypePos
  | PrimTypeNat
  | PrimTypeRat
  deriving (Show, Eq)

data PrimRef
  = PrimRefUnit
  | PrimRefU8 Word8
  | PrimRefU16 Word16
  | PrimRefU32 Word32
  | PrimRefU64 Word64
  | PrimRefI8 Int8
  | PrimRefI16 Int16
  | PrimRefI32 Int32
  | PrimRefI64 Int64
  | PrimRefF32 Float
  | PrimRefF64 Double
  | PrimRefBool Bool
  | PrimRefChar Char
  | PrimRefStr Text
  | PrimRefInt Integer
  | PrimRefNeg Negative
  | PrimRefPos Positive
  | PrimRefNat Natural
  | PrimRefRat Rational
  deriving (Show, Eq)

data Type
  = TypePrim PrimType
  | TypeOpaque OpaqueName
  deriving (Show, Eq)

data TypeRef
  = TypeRefPrimType PrimType
  | TypeRefOpaque OpaqueRef
  deriving (Show, Eq)

data TypeParamRef
  = TypeParamRefPrimRef PrimRef
  | TypeParamRefPrimType PrimType
  | TypeParamRefOpaqueRef OpaqueRef
  deriving (Show, Eq)

data TypeParam = TypeParam
  { _name :: TypeParamName
  , _ref :: TypeParamRef
  } deriving (Show, Eq)

data OpaqueRef = OpaqueRef
  { _name :: OpaqueName
  , _params :: [TypeParamRef]
  } deriving (Show, Eq)

data FuncDef = FuncDef
  { _args :: [(ArgName, TypeRef)]
  , _tags :: Set Tag
  } deriving (Show, Eq)

data SumDef = SumDef
  { _params :: [TypeParamRef]
  , _subtypes :: Map SubtypeName [TypeRef]
  , _tags :: Set Tag
  } deriving (Show, Eq)

data ProductDef = ProductDef
  { _params :: [TypeParamRef]
  , _fields :: Map FieldName TypeRef
  , _tags :: Set Tag
  } deriving (Show, Eq)

data OpaqueDef
  = OpaqueDefSum SumDef
  | OpaqueDefProduct ProductDef
  deriving (Show, Eq)

data ServiceDef = ServiceDef
  { _opaques :: Map OpaqueName OpaqueDef
  , _funcs :: Map FuncName FuncDef
  , _tags :: Set Tag
  } deriving (Show, Eq)

data HttpFormat
  = HttpFormatJson
  deriving (Show, Eq)

data HttpMeta
  = HttpMetaHeader
  deriving (Show, Eq)

data HttpImpl = HttpImpl
  { _directory :: HttpDirectory
  , _port :: HttpPort
  , _meta :: HttpMeta
  , _format :: HttpFormat
  } deriving (Show, Eq)

data Impl
  = ImplHttp HttpImpl
  deriving (Show, Eq)

data Domain = Domain
  { _name :: DomainName
  , _service :: ServiceDef
  , _impl :: Impl
  } deriving (Show, Eq)

data SpecDef = SpecDef
  { _name :: SpecName
  , _domains :: [Domain]
  } deriving (Show, Eq)

data Specs = Specs
  { _defs :: Map Version SpecDef
  } deriving (Show, Eq)