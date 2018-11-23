# Variables utilities


function KN_add_var!(m::Model)

    ptr_int = Cint[0]
    ret = @kn_ccall(add_var, Cint, (Ptr{Nothing}, Ptr{Cint}), m.env.ptr_env.x, ptr_int)
    _checkraise(ret)
    return ptr_int[1]
end


function KN_add_vars!(m::Model, nvars::Int)

    ptr_int = zeros(Cint, nvars)
    ret = @kn_ccall(add_vars, Cint, (Ptr{Nothing}, Cint, Ptr{Cint}), m.env.ptr_env.x, nvars, ptr_int)
    _checkraise(ret)
    return ptr_int
end

##################################################
## Upper and lower bounds utilies
##################################################

# lower bounds
function KN_set_var_lobnd(m::Model, nindex::Integer, val::Cdouble)
    ret = @kn_ccall(set_var_lobnd, Cint, (Ptr{Nothing}, Cint, Cdouble), m.env.ptr_env.x, nindex, val)
    _checkraise(ret)
end


function KN_set_var_lobnds(m::Model, valindex::Vector{Cint}, lobnds::Vector{Cdouble})
    nvar = length(valindex)
    ret = @kn_ccall(set_var_lobnds, Cint,
                    (Ptr{Nothing}, Cint, Ptr{Cint}, Ptr{Cdouble}),
                    m.env.ptr_env.x, nvar, valindex, lobnds)
    _checkraise(ret)
end
function KN_set_var_lobnds(m::Model, lobnds::Vector{Cdouble})
    ret = @kn_ccall(set_var_lobnds_all, Cint, (Ptr{Nothing}, Ptr{Cdouble}),
                    m.env.ptr_env.x, lobnds)
    _checkraise(ret)
end


# upper bounds
function KN_set_var_upbnd(m::Model, nindex::Integer, val::Cdouble)
    ret = @kn_ccall(set_var_upbnd, Cint, (Ptr{Nothing}, Cint, Cdouble), m.env.ptr_env.x, nindex, val)
    _checkraise(ret)
end


function KN_set_var_upbnds(m::Model, valindex::Vector{Cint}, upbnds::Vector{Cdouble})
    nvar = length(valindex)
    ret = @kn_ccall(set_var_upbnds, Cint,
                    (Ptr{Nothing}, Cint, Ptr{Cint}, Ptr{Cdouble}),
                    m.env.ptr_env.x, nvar, valindex, upbnds)
    _checkraise(ret)
end
function KN_set_var_upbnds(m::Model, upbnds::Vector{Cdouble})
    ret = @kn_ccall(set_var_upbnds_all, Cint, (Ptr{Nothing}, Ptr{Cdouble}),
                    m.env.ptr_env.x, upbnds)
    _checkraise(ret)
end


##################################################
## Variables types
##################################################
function KN_set_var_type(m::Model, indexVar::Integer, xType::Integer)
    ret = @kn_ccall(set_var_type, Cint, (Ptr{Nothing}, Cint, Cint),
                    m.env.ptr_env.x, indexVar, xType)
    _checkraise(ret)
end


function KN_set_var_types(m::Model, valindex::Vector{Cint}, xTypes::Vector{Cdouble})
    nvar = length(valindex)
    @assert nvar == length(xTypes)
    ret = @kn_ccall(set_var_types, Cint,
                    (Ptr{Nothing}, Cint, Ptr{Cint}, Ptr{Cdouble}),
                    m.env.ptr_env.x, nvar, valindex, xTypes)
    _checkraise(ret)
end
function KN_set_var_types(m::Model, xTypes::Vector{Cint})
    ret = @kn_ccall(set_var_types_all, Cint, (Ptr{Nothing}, Ptr{Cint}),
                    m.env.ptr_env.x, xTypes)
    _checkraise(ret)
end


##################################################
## Variables properties
##################################################
function KN_set_var_property(m::Model, indexVar::Integer, xProperty::Integer)
    ret = @kn_ccall(set_var_property, Cint, (Ptr{Nothing}, Cint, Cint),
                    m.env.ptr_env.x, indexVar, xProperty)
    _checkraise(ret)
end


function KN_set_var_properties(m::Model, valindex::Vector{Cint}, xProperties::Vector{Cint})
    nvar = length(valindex)
    @assert nvar == length(xProperties)
    ret = @kn_ccall(set_var_properties, Cint,
                    (Ptr{Nothing}, Cint, Ptr{Cint}, Ptr{Cint}),
                    m.env.ptr_env.x, nvar, valindex, xProperties)
    _checkraise(ret)
end
function KN_set_var_properties(m::Model, xProperties::Vector{Cint})
    ret = @kn_ccall(set_var_properties_all, Cint, (Ptr{Nothing}, Ptr{Cint}),
                    m.env.ptr_env.x, xProperties)
    _checkraise(ret)
end


##################################################
## Honor bounds
##################################################
function KN_set_var_honorbnds(m::Model, nindex::Integer, xHonorBound::Cint)
    ret = @kn_ccall(set_var_honorbnd, Cint,
                    (Ptr{Nothing}, Cint, Cint),
                    m.env.ptr_env.x, nindex, xHonorBound)
    _checkraise(ret)
end


function KN_set_var_honorbnds(m::Model, valindex::Vector{Cint}, xHonorBound::Vector{Cint})
    nvar = length(valindex)
    ret = @kn_ccall(set_var_honorbnds, Cint,
                    (Ptr{Nothing}, Cint, Ptr{Cint}, Ptr{Cint}),
                    m.env.ptr_env.x, nvar, valindex, xHonorBound)
    _checkraise(ret)
end
function KN_set_var_honorbnds(m::Model, xHonorBound::Vector{Cint})
    ret = @kn_ccall(set_var_honorbnds_all, Cint, (Ptr{Nothing}, Ptr{Cint}),
                    m.env.ptr_env.x, xHonorBound)
    _checkraise(ret)
end


##################################################
## Initial values
##################################################
function KN_set_var_primal_init_values(m::Model, xinitval::Vector{Cdouble})
    ret = @kn_ccall(set_var_primal_init_values_all, Cint,
                    (Ptr{Nothing}, Ptr{Cdouble}),
                    m.env.ptr_env.x, xinitval)
    _checkraise(ret)
end
function KN_set_var_primal_init_values(m::Model, indx::Integer, xinitval::Cdouble)
    ret = @kn_ccall(set_var_primal_init_value, Cint,
                    (Ptr{Nothing}, Cint, Cdouble), m.env.ptr_env.x, indx, xinitval)
    _checkraise(ret)
end


function KN_set_var_dual_init_values(m::Model, xinitval::Vector{Cdouble})
    ret = @kn_ccall(set_var_dual_init_values_all, Cint,
                    (Ptr{Nothing}, Ptr{Cdouble}),
                    m.env.ptr_env.x, xinitval)
    _checkraise(ret)
end
function KN_set_var_dual_init_values(m::Model, indx::Integer, xinitval::Cdouble)
    ret = @kn_ccall(set_var_dual_init_value, Cint,
                    (Ptr{Nothing}, Cint, Cdouble), m.env.ptr_env.x, indx, xinitval)
    _checkraise(ret)
end


##################################################
## Scalings
##################################################
function KN_set_var_scalings(m::Model, nindex::Integer,
                             xScaleFactors::Cdouble, xScaleCenters::Cdouble)
    ret = @kn_ccall(set_var_scaling, Cint,
                    (Ptr{Nothing}, Cint, Cdouble, Cdouble),
                    m.env.ptr_env.x, nindex, xScaleFactors, xScaleCenters)
    _checkraise(ret)
end
KN_set_var_scalings(m::Model, nindex::Integer, xScaleFactors::Cdouble) =
    KN_set_var_scalings(m, nindex, xScaleFactors, 0.)


function KN_set_var_scalings(m::Model, valindex::Vector{Cint},
                             xScaleFactors::Vector{Cdouble}, xScaleCenters::Vector{Cdouble})
    nvar = length(valindex)
    @assert nvar = length(xScaleFactors) == length(xScaleCenters)
    ret = @kn_ccall(set_var_scalings, Cint,
                    (Ptr{Nothing}, Cint, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}),
                    m.env.ptr_env.x, nvar, valindex, xScaleFactors, xScaleCenters)
    _checkraise(ret)
end
KN_set_var_scalings(m::Model, xIndex::Vector{Cint}, xScaleFactors::Vector{Cdouble}) =
    KN_set_var_scalings(m, xIndex, xScaleFactors, zeros(Cdouble, length(xScaleFactors)))

function KN_set_var_scalings(m::Model,
                             xScaleFactors::Vector{Cdouble}, xScaleCenters::Vector{Cdouble})
    ret = @kn_ccall(set_var_scalings_all, Cint, (Ptr{Nothing}, Ptr{Cdouble}, Ptr{Cdouble}),
                    m.env.ptr_env.x, xScaleFactors, xScaleCenters)
    _checkraise(ret)
end
KN_set_var_scalings(m::Model, xScaleFactors::Vector{Cdouble}) =
    KN_set_var_scalings(m, xScaleFactors, zeros(Cdouble, length(xScaleFactors)))
